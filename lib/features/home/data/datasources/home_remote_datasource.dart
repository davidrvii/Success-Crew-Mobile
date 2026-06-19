/// File: lib/features/home/data/datasources/home_remote_datasource.dart
/// Generated Documentation for home_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

// DTOs
import '../models/home_absence_response.dart';
import '../models/home_attendance_response.dart';
import '../models/home_leave_response.dart';
import '../models/home_notification_response.dart';
import '../models/home_overtime_response.dart';
import '../models/home_user_basic_response.dart';
import '../models/home_out_of_office_response.dart';
import '../../../visitor_tracker/data/models/visit_response.dart';

abstract class HomeRemoteDataSource {
  /// Method `getUserBasic` returning `Future<ApiResponse<HomeUserBasicResponse>>`.
  /// Handles logic operations related to `getUserBasic`.
  Future<ApiResponse<HomeUserBasicResponse>> getUserBasic(int userId);

  /// Method `getNotificationHistory` returning `Future<ApiResponse<HomeNotificationResponse>>`.
  /// Handles logic operations related to `getNotificationHistory`.
  Future<ApiResponse<HomeNotificationResponse>> getNotificationHistory(
    int userId,
  );

  /// Method `getNotificationAll` returning `Future<ApiResponse<HomeNotificationResponse>>`.
  /// Handles logic operations related to `getNotificationAll`.
  Future<ApiResponse<HomeNotificationResponse>> getNotificationAll();

  /// Method `getAttendanceCrew` returning `Future<ApiResponse<HomeAttendanceResponse>>`.
  /// Handles logic operations related to `getAttendanceCrew`.
  Future<ApiResponse<HomeAttendanceResponse>> getAttendanceCrew(int userId);

  /// Method `getAbsenceDetail` returning `Future<ApiResponse<HomeAbsenceResponse>>`.
  /// Handles logic operations related to `getAbsenceDetail`.
  Future<ApiResponse<HomeAbsenceResponse>> getAbsenceDetail(int attendanceId);

  /// Method `getLeaveCrew` returning `Future<ApiResponse<HomeLeaveResponse>>`.
  /// Handles logic operations related to `getLeaveCrew`.
  Future<ApiResponse<HomeLeaveResponse>> getLeaveCrew(int userId);

  /// Method `getLeaveAll` returning `Future<ApiResponse<HomeLeaveResponse>>`.
  /// Handles logic operations related to `getLeaveAll`.
  Future<ApiResponse<HomeLeaveResponse>> getLeaveAll();

  /// Method `getOvertimeCrew` returning `Future<ApiResponse<HomeOvertimeResponse>>`.
  /// Handles logic operations related to `getOvertimeCrew`.
  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeCrew(int userId);

  /// Method `getOvertimeAll` returning `Future<ApiResponse<HomeOvertimeResponse>>`.
  /// Handles logic operations related to `getOvertimeAll`.
  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeAll();

  /// Method `getOutOfOfficeCrew` returning `Future<ApiResponse<HomeOutOfOfficeResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeCrew`.
  Future<ApiResponse<HomeOutOfOfficeResponse>> getOutOfOfficeCrew(int userId);

  /// Method `getOutOfOfficeAll` returning `Future<ApiResponse<HomeOutOfOfficeResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeAll`.
  Future<ApiResponse<HomeOutOfOfficeResponse>> getOutOfOfficeAll();

  /// Method `getVisitSummary` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getVisitSummary`.
  Future<ApiResponse<VisitListResponse>> getVisitSummary();
  /// Method `getVisitList` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getVisitList`.
  Future<ApiResponse<VisitListResponse>> getVisitList();
}

/// Class representing `HomeRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _client;

  HomeRemoteDataSourceImpl(this._client);

  @override
  /// Method `getUserBasic` returning `Future<ApiResponse<HomeUserBasicResponse>>`.
  /// Handles logic operations related to `getUserBasic`.
  Future<ApiResponse<HomeUserBasicResponse>> getUserBasic(int userId) {
    return _get(
      path: ApiPaths.userBasic(userId),
      parser: HomeUserBasicResponse.fromJson,
    );
  }

  @override
  /// Method `getNotificationHistory` returning `Future<ApiResponse<HomeNotificationResponse>>`.
  /// Handles logic operations related to `getNotificationHistory`.
  Future<ApiResponse<HomeNotificationResponse>> getNotificationHistory(
    int userId,
  ) {
    return _get(
      path: ApiPaths.notificationHistory(userId),
      parser: HomeNotificationResponse.fromJson,
    );
  }

  @override
  /// Method `getNotificationAll` returning `Future<ApiResponse<HomeNotificationResponse>>`.
  /// Handles logic operations related to `getNotificationAll`.
  Future<ApiResponse<HomeNotificationResponse>> getNotificationAll() {
    return _get(
      path: ApiPaths.notificationAll,
      parser: HomeNotificationResponse.fromJson,
    );
  }

  @override
  /// Method `getAttendanceCrew` returning `Future<ApiResponse<HomeAttendanceResponse>>`.
  /// Handles logic operations related to `getAttendanceCrew`.
  Future<ApiResponse<HomeAttendanceResponse>> getAttendanceCrew(int userId) {
    return _get(
      path: ApiPaths.attendanceCrew(userId),
      parser: HomeAttendanceResponse.fromJson,
    );
  }

  @override
  /// Method `getAbsenceDetail` returning `Future<ApiResponse<HomeAbsenceResponse>>`.
  /// Handles logic operations related to `getAbsenceDetail`.
  Future<ApiResponse<HomeAbsenceResponse>> getAbsenceDetail(int attendanceId) {
    return _get(
      path: ApiPaths.attendanceDetail(attendanceId),
      parser: HomeAbsenceResponse.fromJson,
    );
  }

  @override
  /// Method `getLeaveCrew` returning `Future<ApiResponse<HomeLeaveResponse>>`.
  /// Handles logic operations related to `getLeaveCrew`.
  Future<ApiResponse<HomeLeaveResponse>> getLeaveCrew(int userId) {
    return _get(
      path: ApiPaths.leaveCrew(userId),
      parser: HomeLeaveResponse.fromJson,
    );
  }

  @override
  /// Method `getLeaveAll` returning `Future<ApiResponse<HomeLeaveResponse>>`.
  /// Handles logic operations related to `getLeaveAll`.
  Future<ApiResponse<HomeLeaveResponse>> getLeaveAll() {
    return _get(path: ApiPaths.leaveAll, parser: HomeLeaveResponse.fromJson);
  }

  @override
  /// Method `getOvertimeCrew` returning `Future<ApiResponse<HomeOvertimeResponse>>`.
  /// Handles logic operations related to `getOvertimeCrew`.
  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeCrew(int userId) {
    return _get(
      path: ApiPaths.overtimeCrew(userId),
      parser: HomeOvertimeResponse.fromJson,
    );
  }

  @override
  /// Method `getOvertimeAll` returning `Future<ApiResponse<HomeOvertimeResponse>>`.
  /// Handles logic operations related to `getOvertimeAll`.
  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeAll() {
    return _get(path: ApiPaths.overtimeAll, parser: HomeOvertimeResponse.fromJson);
  }

  @override
  /// Method `getOutOfOfficeCrew` returning `Future<ApiResponse<HomeOutOfOfficeResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeCrew`.
  Future<ApiResponse<HomeOutOfOfficeResponse>> getOutOfOfficeCrew(int userId) {
    return _get(
      path: ApiPaths.outOfOfficeCrew(userId),
      parser: HomeOutOfOfficeResponse.fromJson,
    );
  }

  @override
  /// Method `getOutOfOfficeAll` returning `Future<ApiResponse<HomeOutOfOfficeResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeAll`.
  Future<ApiResponse<HomeOutOfOfficeResponse>> getOutOfOfficeAll() {
    return _get(
      path: ApiPaths.outOfOfficeAll,
      parser: HomeOutOfOfficeResponse.fromJson,
    );
  }

  @override
  /// Method `getVisitSummary` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getVisitSummary`.
  Future<ApiResponse<VisitListResponse>> getVisitSummary() {
    return _get(
      path: ApiPaths.visitAll,
      parser: VisitListResponse.fromJson,
    );
  }

  @override
  /// Method `getVisitList` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getVisitList`.
  Future<ApiResponse<VisitListResponse>> getVisitList() {
    return _get(
      path: ApiPaths.visitList,
      parser: VisitListResponse.fromJson,
    );
  }

  // PRIVATE HELPER
  Future<ApiResponse<T>> _get<T>({
    required String path,
    required T Function(Map<String, dynamic> json) parser,
  }) {
    return ApiResponse.guard(
      request: () => _client.get(path),
      parser: (json) => parser(json as Map<String, dynamic>),
    );
  }
}
