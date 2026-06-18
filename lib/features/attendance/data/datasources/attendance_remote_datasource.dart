import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/attendance_model.dart';
import '../models/checkin_request.dart';
import '../models/checkout_request.dart';
import '../models/add_attendance_request.dart';
import '../models/update_attendance_request.dart';

abstract class AttendanceRemoteDataSource {
  /// GET /attendance/all — all records (admin/owner)
  Future<ApiResponse<AttendanceListResponse>> getAllAttendance();

  /// GET /attendance/basic?date=YYYY-MM-DD — today's check-in/out state
  Future<ApiResponse<AttendanceBasicResponse>> getAttendanceBasic({
    String? date,
  });

  /// GET /attendance/crew/:userId — full crew history with stats
  Future<ApiResponse<CrewAttendanceResponse>> getAttendanceHistory(int userId);

  /// GET /attendance/detail/:id
  Future<ApiResponse<AttendanceDetailResponse>> getAttendanceDetail(int id);

  /// POST /attendance/add — admin creates attendance for a user
  Future<ApiResponse<AddAttendanceResponse>> addAttendance(
    AddAttendanceRequest request,
  );

  /// PATCH /attendance/checkin — user checks in (date-based, no ID)
  Future<ApiResponse<CheckInResponse>> checkIn(CheckInRequest request);

  /// PATCH /attendance/checkout — user checks out (date-based, no ID)
  Future<ApiResponse<CheckOutResponse>> checkOut(CheckOutRequest request);

  /// PUT /attendance/update/:attendanceId — admin updates full record
  Future<ApiResponse<UpdateAttendanceResponse>> updateAttendance(
    int attendanceId,
    UpdateAttendanceRequest request,
  );

  /// DELETE /attendance/delete/:attendanceId
  Future<ApiResponse<DeleteAttendanceResponse>> deleteAttendance(int id);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final DioClient _client;
  AttendanceRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<AttendanceListResponse>> getAllAttendance() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceAll),
      parser: (json) =>
          AttendanceListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<AttendanceBasicResponse>> getAttendanceBasic({
    String? date,
  }) {
    final queryParams = date != null ? {'date': date} : null;
    return ApiResponse.guard(
      request: () => _client.get(
        ApiPaths.attendanceBasic,
        queryParameters: queryParams,
      ),
      parser: (json) =>
          AttendanceBasicResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CrewAttendanceResponse>> getAttendanceHistory(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceCrew(userId)),
      parser: (json) =>
          CrewAttendanceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<AttendanceDetailResponse>> getAttendanceDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceDetail(id)),
      parser: (json) =>
          AttendanceDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<AddAttendanceResponse>> addAttendance(
    AddAttendanceRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(
        ApiPaths.attendanceAdd,
        data: request.toJson(),
      ),
      parser: (json) =>
          AddAttendanceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CheckInResponse>> checkIn(CheckInRequest request) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.attendanceCheckIn,
        data: request.toJson(),
      ),
      parser: (json) => CheckInResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CheckOutResponse>> checkOut(CheckOutRequest request) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.attendanceCheckOut,
        data: request.toJson(),
      ),
      parser: (json) =>
          CheckOutResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UpdateAttendanceResponse>> updateAttendance(
    int attendanceId,
    UpdateAttendanceRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.put(
        ApiPaths.attendanceUpdate(attendanceId),
        data: request.toJson(),
      ),
      parser: (json) =>
          UpdateAttendanceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<DeleteAttendanceResponse>> deleteAttendance(int id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.attendanceDelete(id)),
      parser: (json) =>
          DeleteAttendanceResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
