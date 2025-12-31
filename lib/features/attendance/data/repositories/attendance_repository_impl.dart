import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';

import '../datasources/attendance_remote_datasource.dart';
import '../models/attendance_model.dart';
import '../models/checkin_request.dart';
import '../models/checkout_request.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource _remote;
  final UserSession _session;

  AttendanceRepositoryImpl(this._remote, this._session);

  @override
  Future<ApiResponse<List<Attendance>>> getAttendanceHistory() async {
    final userId = await _requireUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }

    final res = await _remote.getAttendanceHistory(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.items ?? const <AttendanceDto>[];
    final mapped = items.map(_mapDtoToEntity).toList();

    return ApiResponse.success(mapped);
  }

  @override
  Future<ApiResponse<Attendance>> getAttendanceDetail(String id) async {
    final res = await _remote.getAttendanceDetail(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.detail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (attendance detail is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<Attendance>> checkIn(CheckInRequest request) async {
    final res = await _remote.checkIn(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.attendance;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected check-in response (attendance is null).',
        ),
      );
    }

    await _session.saveTodayAttendanceId(dto.id.toString());

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<Attendance>> checkOut(
    String attendanceId,
    CheckOutRequest request,
  ) async {
    final res = await _remote.checkOut(attendanceId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.attendance;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected check-out response (attendance is null).',
        ),
      );
    }
    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  // ========= helpers =========

  Future<String?> _requireUserId() async {
    final session = await _session.readSession();
    final userId = session?['user_id']?.toString();
    if (userId == null || userId.isEmpty) return null;
    return userId;
  }

  Attendance _mapDtoToEntity(AttendanceDto dto) {
    return Attendance(
      id: dto.id,
      userId: dto.userId,
      attendanceDate: dto.attendanceDate,
      checkInAt: dto.checkInAt,
      checkOutAt: dto.checkOutAt,
      status: dto.status,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
