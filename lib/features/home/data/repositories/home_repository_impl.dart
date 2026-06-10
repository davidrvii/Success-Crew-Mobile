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
import '../models/home_absence_response.dart';
import '../models/home_attendance_response.dart';
import '../models/home_leave_response.dart';
import '../models/home_notification_response.dart';
import '../models/home_overtime_response.dart';
import '../models/home_user_basic_response.dart';
import '../../../visitor_tracker/data/models/visit_response.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remote;
  final UserSession _session;

  HomeRepositoryImpl(this._remote, this._session);

  @override
  Future<ApiResponse<HomeSummary>> getHomeSummary() async {
    final userIdRes = await _requireUserId();
    if (!userIdRes.isSuccess) return ApiResponse.failure(userIdRes.error!);
    final userId = userIdRes.data!;

    final userBasicRes = await _remote.getUserBasic(userId);
    if (!userBasicRes.isSuccess) {
      return ApiResponse.failure(userBasicRes.error!);
    }

    final userBasic = userBasicRes.data!;
    final isOwner = _isOwnerRole(userBasic.roleName);

    final notifF = isOwner
        ? _remote.getNotificationAdmin()
        : _remote.getNotificationHistory(userId);

    final leaveF = isOwner
        ? _remote.getLeaveAdmin()
        : _remote.getLeaveCrew(userId);

    final overtimeF = isOwner
        ? _remote.getOvertimeAdmin()
        : _remote.getOvertimeCrew(userId);

    final attendanceF = _remote.getAttendanceCrew(userId);

    final visitF = isOwner ? _remote.getVisitSummary() : null;

    final notifRes = await _requireSuccess(notifF);
    if (!notifRes.isSuccess) return ApiResponse.failure(notifRes.error!);

    final attendanceRes = await _requireSuccess(attendanceF);
    if (!attendanceRes.isSuccess) {
      return ApiResponse.failure(attendanceRes.error!);
    }

    final leaveRes = await _requireSuccess(leaveF);
    if (!leaveRes.isSuccess) return ApiResponse.failure(leaveRes.error!);

    final overtimeRes = await _requireSuccess(overtimeF);
    if (!overtimeRes.isSuccess) return ApiResponse.failure(overtimeRes.error!);

    VisitListResponse? visit;
    if (visitF != null) {
      final visitRes = await _requireSuccess(visitF);
      if (!visitRes.isSuccess) return ApiResponse.failure(visitRes.error!);
      visit = visitRes.data;
    }

    final todayAttendanceId = await _session.readTodayAttendanceId();
    final todayAbsenceRes = await _resolveTodayAbsence(todayAttendanceId);
    if (!todayAbsenceRes.isSuccess) {
      return ApiResponse.failure(todayAbsenceRes.error!);
    }

    final summary = _buildSummary(
      userBasic: userBasic,
      notif: notifRes.data!,
      attendance: attendanceRes.data!,
      leave: leaveRes.data!,
      overtime: overtimeRes.data!,
      visit: visit,
      todayAbsence: todayAbsenceRes.data!,
    );

    return ApiResponse.success(summary);
  }

  // =========================
  // SESSION HELPERS
  // =========================

  Future<ApiResponse<int>> _requireUserId() async {
    final int? userId = await _session.readUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }
    return ApiResponse.success(userId);
  }

  bool _isOwnerRole(String roleName) =>
      roleName.trim().toLowerCase() == 'owner';

  // =========================
  // TODAY ABSENCE
  // =========================

  Future<ApiResponse<HomeTodayAbsence>> _resolveTodayAbsence(
    int? attendanceId,
  ) async {
    final now = DateTime.now();

    if (attendanceId == null) {
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

    final HomeAbsenceResponse? detail = detailRes.data;
    if (detail == null) {
      await _session.clearTodayAttendanceId();
      return ApiResponse.success(HomeTodayAbsence.notCheckedIn());
    }

    final checkInAt = DateTime.tryParse(detail.checkIn ?? '');
    final checkOutAt = DateTime.tryParse(detail.checkOut ?? '');
    final date = checkInAt ?? checkOutAt;

    // Data attendance bukan untuk hari ini → reset session attendanceId
    if (date == null || !_isSameDay(date, now)) {
      await _session.clearTodayAttendanceId();
      return ApiResponse.success(HomeTodayAbsence.notCheckedIn());
    }

    return ApiResponse.success(
      HomeTodayAbsence.checkedIn(
        attendanceId: detail.attendanceId,
        checkInAt: checkInAt,
        checkOutAt: checkOutAt,
        status: detail.status,
      ),
    );
  }

  // =========================
  // BUILD SUMMARY (DTO -> ENTITY)
  // =========================

  bool _isToday(DateTime? dt) {
    if (dt == null) return false;
    final now = DateTime.now();
    return dt.year == now.year && dt.month == now.month && dt.day == now.day;
  }

  HomeSummary _buildSummary({
    required HomeUserBasicResponse userBasic,
    required HomeNotificationResponse notif,
    required HomeAttendanceResponse attendance,
    required HomeLeaveResponse leave,
    required HomeOvertimeResponse overtime,
    required VisitListResponse? visit,
    required HomeTodayAbsence todayAbsence,
  }) {
    final user = HomeUserBasic(
      userId: userBasic.userId,
      userName: userBasic.userName,
      roleName: userBasic.roleName,
      userPhoto: userBasic.userPhoto,
    );

    int visitorsToday = 0;
    int walkInToday = 0;
    int callInToday = 0;
    int chatInToday = 0;

    if (visit != null) {
      for (final v in visit.visits) {
        if (_isToday(v.createdAt)) {
          visitorsToday++;
          final type = (v.visitType ?? '').trim().toLowerCase();
          if (type == 'walk-in' || type == 'walk in') {
            walkInToday++;
          } else if (type == 'call-in' || type == 'call in') {
            callInToday++;
          } else if (type == 'chat-in' || type == 'chat in') {
            chatInToday++;
          }
        }
      }
    }

    return HomeSummary(
      user: user,
      unreadNotificationCount: notif.unreadCount,
      attendance: HomeAttendanceSummary(
        today: todayAbsence,
        presentCount: attendance.present,
        lateCount: attendance.late,
        leaveCount: attendance.leave,
        overtimeCount: attendance.overtime,
      ),
      requests: HomeRequestSummary(
        pendingLeaveCount: leave.pendingCount,
        pendingOvertimeCount: overtime.pendingCount,
      ),
      visitors: HomeVisitSummary(
        visitorsToday: visitorsToday,
        walkInToday: walkInToday,
        callInToday: callInToday,
        chatInToday: chatInToday,
        totalRevenue: 0,
        totalDistance: 0,
      ),
    );
  }

  // =========================
  // GENERIC HELPERS
  // =========================

  Future<ApiResponse<T>> _requireSuccess<T>(
    Future<ApiResponse<T>> future,
  ) async {
    final res = await future;
    if (!res.isSuccess) return ApiResponse.failure(res.error!);
    return res;
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
