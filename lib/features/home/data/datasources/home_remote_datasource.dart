import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/home_absence_response.dart';
import '../models/home_attendance_response.dart';
import '../models/home_leave_response.dart';
import '../models/home_notification_response.dart';
import '../models/home_overtime_response.dart';
import '../models/home_user_basic_response.dart';
import '../models/home_visit_summary_response.dart';

abstract class HomeRemoteDataSource {
  Future<ApiResponse<HomeUserBasicResponse>> getUserBasic(String userId);

  Future<ApiResponse<HomeNotificationResponse>> getNotificationHistory(
    String userId,
  );

  Future<ApiResponse<HomeAttendanceResponse>> getAttendanceCrew(String userId);

  Future<ApiResponse<HomeAbsenceResponse>> getAbsenceDetail(
    String attendanceId,
  );

  Future<ApiResponse<HomeLeaveResponse>> getLeaveCrew(String userId);

  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeCrew(String userId);

  Future<ApiResponse<HomeVisitSummaryResponse>> getVisitSummary();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient _client;

  HomeRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<HomeUserBasicResponse>> getUserBasic(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userBasic(userId)),
      parser: (json) =>
          HomeUserBasicResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<HomeNotificationResponse>> getNotificationHistory(
    String userId,
  ) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationHistory(userId)),
      parser: (json) =>
          HomeNotificationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<HomeAttendanceResponse>> getAttendanceCrew(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceCrew(userId)),
      parser: (json) =>
          HomeAttendanceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<HomeAbsenceResponse>> getAbsenceDetail(
    String attendanceId,
  ) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceDetail(attendanceId)),
      parser: (json) =>
          HomeAbsenceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<HomeLeaveResponse>> getLeaveCrew(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.leaveCrew(userId)),
      parser: (json) =>
          HomeLeaveResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<HomeOvertimeResponse>> getOvertimeCrew(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeCrew(userId)),
      parser: (json) =>
          HomeOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<HomeVisitSummaryResponse>> getVisitSummary() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitAdmin),
      parser: (json) =>
          HomeVisitSummaryResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
