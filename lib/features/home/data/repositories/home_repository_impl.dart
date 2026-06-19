/// File: lib/features/home/data/repositories/home_repository_impl.dart
/// Generated Documentation for home_repository_impl.dart

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
import '../models/home_out_of_office_response.dart';
import '../models/home_overtime_response.dart';
import '../models/home_user_basic_response.dart';
import '../../../visitor_tracker/data/models/visit_response.dart';

/// Class representing `HomeRepositoryImpl`.
/// Auto-generated class documentation.
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remote;
  final UserSession _session;

  HomeRepositoryImpl(this._remote, this._session);

  @override
  /// Method `getHomeSummary` returning `Future<ApiResponse<HomeSummary>>`.
  /// Handles logic operations related to `getHomeSummary`.
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
        ? _remote.getNotificationAll()
        : _remote.getNotificationHistory(userId);

    final leaveF = isOwner
        ? _remote.getLeaveAll()
        : _remote.getLeaveCrew(userId);

    final overtimeF = isOwner
        ? _remote.getOvertimeAll()
        : _remote.getOvertimeCrew(userId);

    final outOfOfficeF = isOwner
        ? _remote.getOutOfOfficeAll()
        : _remote.getOutOfOfficeCrew(userId);

    final attendanceF = _remote.getAttendanceCrew(userId);

    final visitF = isOwner ? _remote.getVisitSummary() : _remote.getVisitList();

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

    final outOfOfficeRes = await _requireSuccess(outOfOfficeF);
    if (!outOfOfficeRes.isSuccess) return ApiResponse.failure(outOfOfficeRes.error!);

    final visitRes = await _requireSuccess(visitF);
    if (!visitRes.isSuccess) return ApiResponse.failure(visitRes.error!);
    final visit = visitRes.data;

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
      outOfOffice: outOfOfficeRes.data!,
      visit: visit,
      todayAbsence: todayAbsenceRes.data!,
    );

    return ApiResponse.success(summary);
  }

  // =========================
  // SESSION HELPERS
  // =========================

  /// Method `_requireUserId` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `_requireUserId`.
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

  /// Method `_isOwnerRole` returning `bool`.
  /// Handles logic operations related to `_isOwnerRole`.
  bool _isOwnerRole(String roleName) =>
      roleName.trim().toLowerCase() == 'owner';

  // =========================
  // TODAY ABSENCE
  // =========================

  /// Method `_resolveTodayAbsence` returning `Future<ApiResponse<HomeTodayAbsence>>`.
  /// Handles logic operations related to `_resolveTodayAbsence`.
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

  /// Method `_isToday` returning `bool`.
  /// Handles logic operations related to `_isToday`.
  bool _isToday(DateTime? dt) {
    if (dt == null) return false;
    final now = DateTime.now();
    return dt.year == now.year && dt.month == now.month && dt.day == now.day;
  }

  /// Method `_isThisWeek` returning `bool`.
  /// Handles logic operations related to `_isThisWeek`.
  bool _isThisWeek(DateTime? dt) {
    if (dt == null) return false;
    final now = DateTime.now();
    final monday = now.subtract(Duration(days: now.weekday - 1));
    final startOfWeek = DateTime(monday.year, monday.month, monday.day);
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    return dt.isAfter(startOfWeek.subtract(const Duration(seconds: 1))) &&
        dt.isBefore(endOfWeek);
  }

  HomeSummary _buildSummary({
    required HomeUserBasicResponse userBasic,
    required HomeNotificationResponse notif,
    required HomeAttendanceResponse attendance,
    required HomeLeaveResponse leave,
    required HomeOvertimeResponse overtime,
    required HomeOutOfOfficeResponse outOfOffice,
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
    int totalServicesThisWeek = 0;
    int totalProductsSoldThisWeek = 0;

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

        if (_isThisWeek(v.createdAt)) {
          if (v.unitsServiced != null) {
            totalServicesThisWeek += v.unitsServiced!.length;
          }
          if (v.productsSold != null) {
            for (final p in v.productsSold!) {
              totalProductsSoldThisWeek += (p.quantity ?? 0);
            }
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
        outOfOfficeCount: attendance.outOfOffice,
      ),
      requests: HomeRequestSummary(
        pendingLeaveCount: leave.pendingCount,
        pendingOutOfOfficeCount: outOfOffice.pendingCount,
        pendingOvertimeCount: overtime.pendingCount,
      ),
      visitors: HomeVisitSummary(
        visitorsToday: visitorsToday,
        walkInToday: walkInToday,
        callInToday: callInToday,
        chatInToday: chatInToday,
        totalRevenue: 0,
        totalDistance: 0,
        totalServicesThisWeek: totalServicesThisWeek,
        totalProductsSoldThisWeek: totalProductsSoldThisWeek,
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

  /// Method `_isSameDay` returning `bool`.
  /// Handles logic operations related to `_isSameDay`.
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}
