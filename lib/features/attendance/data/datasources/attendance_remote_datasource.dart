import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/attendance_model.dart';
import '../models/checkin_request.dart';
import '../models/checkout_request.dart';

abstract class AttendanceRemoteDataSource {
  Future<ApiResponse<AttendanceListResponse>> getAttendanceHistory(int userId);

  Future<ApiResponse<AttendanceDetailResponse>> getAttendanceDetail(int id);

  Future<ApiResponse<CheckInResponse>> checkIn(CheckInRequest request);

  Future<ApiResponse<CheckOutResponse>> checkOut(
    int attendanceId,
    CheckOutRequest request,
  );

  Future<ApiResponse<DeleteAttendanceResponse>> deleteAttendance(int id);

  Future<ApiResponse<AttendanceListResponse>> getAllAttendanceAdmin();
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final DioClient _client;
  AttendanceRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<AttendanceListResponse>> getAttendanceHistory(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceCrew(userId)),
      parser: (json) =>
          AttendanceListResponse.fromJson(json as Map<String, dynamic>),
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
  Future<ApiResponse<CheckInResponse>> checkIn(CheckInRequest request) {
    return ApiResponse.guard(
      request: () =>
          _client.post(ApiPaths.attendanceCheckIn, data: request.toJson()),
      parser: (json) => CheckInResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CheckOutResponse>> checkOut(
    int attendanceId,
    CheckOutRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.attendanceCheckOut(attendanceId),
        data: request.toJson(),
      ),
      parser: (json) => CheckOutResponse.fromJson(json as Map<String, dynamic>),
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

  @override
  Future<ApiResponse<AttendanceListResponse>> getAllAttendanceAdmin() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceAdmin),
      parser: (json) =>
          AttendanceListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
