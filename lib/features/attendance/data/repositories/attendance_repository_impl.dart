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
  Future<ApiResponse<AttendanceHistoryData>> getAttendanceHistory() async {
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

    // Calculate stats filtered by the current calendar year
    final now = DateTime.now();
    final currentYear = now.year;

    final currentYearEntries = mapped.where((a) {
      if (a.attendanceDate == null) return false;
      return a.attendanceDate!.toLocal().year == currentYear;
    }).toList();

    final presentCount = currentYearEntries.where((a) {
      final statusLower = (a.status ?? '').toLowerCase().trim();
      return a.checkInAt != null && statusLower != 'tidak hadir';
    }).length;

    final lateCount = currentYearEntries.where((a) {
      final statusLower = (a.status ?? '').toLowerCase().trim();
      return statusLower == 'telat';
    }).length;

    final overtimeCount = currentYearEntries.fold<int>(0, (sum, a) {
      final ot = a.overtime ?? 0;
      if (ot > 0) return sum + ot;

      // Fallback
      if (a.checkInAt == null || a.checkOutAt == null) return sum;
      final diff = a.checkOutAt!.difference(a.checkInAt!);
      final hours = diff.inHours;
      final calcOt = hours > 8 ? hours - 8 : 0;
      return sum + calcOt;
    });

    final leaveCount = res.data?.leave ?? 0;

    return ApiResponse.success(
      AttendanceHistoryData(
        history: mapped,
        presentCount: presentCount,
        lateCount: lateCount,
        leaveCount: leaveCount,
        overtimeCount: overtimeCount,
      ),
    );
  }

  @override
  Future<ApiResponse<Attendance>> getAttendanceDetail(int id) async {
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

    await _session.saveTodayAttendanceId(dto.id);

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<Attendance>> checkOut(
    int attendanceId,
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

  Future<int?> _requireUserId() async {
    final session = await _session.readSession();
    final userId = session?['user_id'];
    if (userId == null) return null;
    if (userId is num) return userId.toInt();
    if (userId is String) {
      if (userId.trim().isEmpty) return null;
      return int.tryParse(userId);
    }
    return null;
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
      overtime: dto.overtime,
    );
  }
}
