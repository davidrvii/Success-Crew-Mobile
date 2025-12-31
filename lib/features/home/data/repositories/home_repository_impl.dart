import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/home_attendance_summary.dart';
import '../../domain/entities/home_request_summary.dart';
import '../../domain/entities/home_summary.dart';
import '../../domain/entities/home_user_basic.dart';
import '../../domain/entities/home_visit_summary.dart';
import '../../domain/repositories/home_repository.dart';

import '../datasources/home_remote_datasource.dart';
import '../models/home_attendance_response.dart';
import '../models/home_leave_response.dart';
import '../models/home_notification_response.dart';
import '../models/home_overtime_response.dart';
import '../models/home_visit_summary_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remote;
  final UserSession _session;

  HomeRepositoryImpl(this._remote, this._session);

  @override
  Future<ApiResponse<HomeSummary>> getHomeSummary() async {
    final userId = await _session.readUserId();
    if (userId == null || userId.isEmpty) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }

    final userBasicF = _remote.getUserBasic(userId);
    final notifF = _remote.getNotificationHistory(userId);
    final attendanceListF = _remote.getAttendanceCrew(userId);
    final leaveF = _remote.getLeaveCrew(userId);
    final overtimeF = _remote.getOvertimeCrew(userId);
    final visitF = _remote.getVisitSummary();

    final userBasicRes = await userBasicF;
    if (!userBasicRes.isSuccess) {
      return ApiResponse.failure(userBasicRes.error!);
    }

    final notifRes = await notifF;
    if (!notifRes.isSuccess) return ApiResponse.failure(notifRes.error!);

    final attendanceRes = await attendanceListF;
    if (!attendanceRes.isSuccess) {
      return ApiResponse.failure(attendanceRes.error!);
    }

    final leaveRes = await leaveF;
    if (!leaveRes.isSuccess) return ApiResponse.failure(leaveRes.error!);

    final overtimeRes = await overtimeF;
    if (!overtimeRes.isSuccess) return ApiResponse.failure(overtimeRes.error!);

    final visitRes = await visitF;
    if (!visitRes.isSuccess) return ApiResponse.failure(visitRes.error!);

    final todayAttendanceId = await _session.readTodayAttendanceId();
    final todayAbsenceRes = await _resolveTodayAbsence(todayAttendanceId);
    if (!todayAbsenceRes.isSuccess) {
      return ApiResponse.failure(todayAbsenceRes.error!);
    }
    final todayAbsence = todayAbsenceRes.data!;

    final notifItems = notifRes.data?.items ?? const <HomeNotificationDto>[];
    final unreadCount = notifItems.where((n) => n.isRead == false).length;

    final attendanceItems =
        attendanceRes.data?.items ?? const <HomeAttendanceDto>[];
    final breakdown = _buildAttendanceBreakdown(attendanceItems);

    final leaveItems = leaveRes.data?.items ?? const <HomeLeaveDto>[];
    final pendingLeave = leaveItems.where((l) => _isPending(l.status)).length;

    final overtimeItems = overtimeRes.data?.items ?? const <HomeOvertimeDto>[];
    final pendingOvertime = overtimeItems
        .where((o) => _isPending(o.status))
        .length;

    final visitItems = visitRes.data?.items ?? const <HomeVisitDto>[];
    final visitAgg = _buildVisitSummary(visitItems);

    final ub = userBasicRes.data?.userBasic;
    final user = HomeUserBasic(
      userId: ub?.userId ?? 0,
      userName: ub?.userName ?? '',
      roleName: ub?.roleName,
      userPhoto: ub?.userPhoto,
    );

    final summary = HomeSummary(
      user: user,
      unreadNotificationCount: unreadCount,
      attendance: HomeAttendanceSummary(
        today: todayAbsence,
        hadirCount: breakdown.hadir,
        telatCount: breakdown.telat,
        cutiCount: breakdown.cuti,
        lemburCount: breakdown.lembur,
      ),
      requests: HomeRequestSummary(
        pendingLeaveCount: pendingLeave,
        pendingOvertimeCount: pendingOvertime,
      ),
      visitors: HomeVisitSummary(
        visitorsToday: visitAgg.visitorsToday,
        totalRevenue: visitAgg.totalRevenue,
        totalDistance: visitAgg.totalDistance,
      ),
    );

    return ApiResponse.success(summary);
  }

  Future<ApiResponse<HomeTodayAbsence>> _resolveTodayAbsence(
    String? attendanceId,
  ) async {
    final now = DateTime.now();

    if (attendanceId == null || attendanceId.isEmpty) {
      return ApiResponse.success(HomeTodayAbsence.notCheckedIn());
    }

    final detailRes = await _remote.getAbsenceDetail(attendanceId);

    if (!detailRes.isSuccess) {
      final err = detailRes.error!;
      if (err.type == NetworkErrorType.notFound) {
        await _session.clearTodayAttendanceId();
        return ApiResponse.success(HomeTodayAbsence.notCheckedIn());
      }
      return ApiResponse.failure(err);
    }

    final detail = detailRes.data?.detail;
    if (detail == null) {
      await _session.clearTodayAttendanceId();
      return ApiResponse.success(HomeTodayAbsence.notCheckedIn());
    }

    final date = detail.attendanceDate ?? detail.checkInAt ?? detail.checkOutAt;
    if (date == null || !_isSameDay(date, now)) {
      await _session.clearTodayAttendanceId();
      return ApiResponse.success(HomeTodayAbsence.notCheckedIn());
    }

    return ApiResponse.success(
      HomeTodayAbsence.checkedIn(
        attendanceId: detail.id,
        checkInAt: detail.checkInAt,
        checkOutAt: detail.checkOutAt,
        status: detail.status,
      ),
    );
  }

  _AttendanceBreakdown _buildAttendanceBreakdown(
    List<HomeAttendanceDto> items,
  ) {
    int hadir = 0, telat = 0, cuti = 0, lembur = 0;

    for (final it in items) {
      final status = (it.status ?? '').toLowerCase().trim();

      if (status.isEmpty) continue;

      if (status.contains('hadir') || status == 'present') {
        hadir++;
      } else if (status.contains('telat') || status.contains('late')) {
        telat++;
      } else if (status.contains('cuti') || status.contains('leave')) {
        cuti++;
      } else if (status.contains('lembur') || status.contains('overtime')) {
        lembur++;
      }
    }

    return _AttendanceBreakdown(hadir, telat, cuti, lembur);
  }

  bool _isPending(String? status) {
    final s = (status ?? '').toLowerCase().trim();
    if (s.isEmpty) return false;

    return s.contains('pending') ||
        s.contains('wait') ||
        s.contains('waiting') ||
        s.contains('process') ||
        s.contains('requested');
  }

  _VisitAgg _buildVisitSummary(List<HomeVisitDto> items) {
    final now = DateTime.now();

    int visitorsToday = 0;
    num totalRevenue = 0;
    num totalDistance = 0;

    for (final it in items) {
      final createdAt = it.createdAt;
      if (createdAt != null && _isSameDay(createdAt, now)) {
        visitorsToday++;
      }

      totalRevenue += (it.revenue ?? 0);
      totalDistance += (it.distance ?? 0);
    }

    return _VisitAgg(
      visitorsToday: visitorsToday,
      totalRevenue: totalRevenue,
      totalDistance: totalDistance,
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _AttendanceBreakdown {
  final int hadir;
  final int telat;
  final int cuti;
  final int lembur;

  const _AttendanceBreakdown(this.hadir, this.telat, this.cuti, this.lembur);
}

class _VisitAgg {
  final int visitorsToday;
  final num totalRevenue;
  final num totalDistance;

  const _VisitAgg({
    required this.visitorsToday,
    required this.totalRevenue,
    required this.totalDistance,
  });
}
