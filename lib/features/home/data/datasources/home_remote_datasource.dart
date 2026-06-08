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
import '../models/home_visit_summary_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponse<HomeUserBasicResponse>> getUserBasic(int userId);

  Future<ApiResponse<HomeNotificationResponse>> getNotificationHistory(
    int userId,
  );

  Future<ApiResponse<HomeNotificationResponse>> getNotificationAdmin();

  Future<ApiResponse<HomeAttendanceResponse>> getAttendanceCrew(int userId);

  Future<ApiResponse<HomeAbsenceResponse>> getAbsenceDetail(int attendanceId);

  Future<ApiResponse<HomeLeaveResponse>> getLeaveCrew(int userId);

  Future<ApiResponse<HomeLeaveResponse>> getLeaveAdmin();

  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeCrew(int userId);

  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeAdmin();

  Future<ApiResponse<HomeVisitSummaryResponse>> getVisitSummary();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _client;

  HomeRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<HomeUserBasicResponse>> getUserBasic(int userId) {
    return _get(
      path: ApiPaths.userBasic(userId),
      parser: HomeUserBasicResponse.fromJson,
    );
  }

  @override
  Future<ApiResponse<HomeNotificationResponse>> getNotificationHistory(
    int userId,
  ) {
    return _get(
      path: ApiPaths.notificationHistory(userId),
      parser: HomeNotificationResponse.fromJson,
    );
  }

  @override
  Future<ApiResponse<HomeNotificationResponse>> getNotificationAdmin() {
    return _get(
      path: '/notification/admin',
      parser: HomeNotificationResponse.fromJson,
    );
  }

  @override
  Future<ApiResponse<HomeAttendanceResponse>> getAttendanceCrew(int userId) {
    return _get(
      path: ApiPaths.attendanceCrew(userId),
      parser: HomeAttendanceResponse.fromJson,
    );
  }

  @override
  Future<ApiResponse<HomeAbsenceResponse>> getAbsenceDetail(int attendanceId) {
    return _get(
      path: ApiPaths.attendanceDetail(attendanceId),
      parser: HomeAbsenceResponse.fromJson,
    );
  }

  @override
  Future<ApiResponse<HomeLeaveResponse>> getLeaveCrew(int userId) {
    return _get(
      path: ApiPaths.leaveCrew(userId),
      parser: HomeLeaveResponse.fromJson,
    );
  }

  @override
  Future<ApiResponse<HomeLeaveResponse>> getLeaveAdmin() {
    return _get(path: '/leave/admin', parser: HomeLeaveResponse.fromJson);
  }

  @override
  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeCrew(int userId) {
    return _get(
      path: ApiPaths.overtimeCrew(userId),
      parser: HomeOvertimeResponse.fromJson,
    );
  }

  @override
  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeAdmin() {
    return _get(path: '/overtime/admin', parser: HomeOvertimeResponse.fromJson);
  }

  @override
  Future<ApiResponse<HomeVisitSummaryResponse>> getVisitSummary() {
    return _get(
      path: ApiPaths.visitAdmin,
      parser: HomeVisitSummaryResponse.fromJson,
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
