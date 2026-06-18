import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/attendance.dart';
import '../../domain/repositories/attendance_repository.dart';

import '../datasources/attendance_remote_datasource.dart';
import '../models/attendance_model.dart';
import '../models/checkin_request.dart';
import '../models/checkout_request.dart';
import '../models/add_attendance_request.dart';
import '../models/update_attendance_request.dart';

class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceRemoteDataSource _remote;
  final UserSession _session;

  AttendanceRepositoryImpl(this._remote, this._session);

  // ─────────────────── mappers ───────────────────

  Attendance _mapDto(AttendanceDto dto) {
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

  AttendanceBasic _mapBasic(AttendanceBasicDto dto) {
    return AttendanceBasic(
      attendanceIn: dto.attendanceIn,
      attendanceOut: dto.attendanceOut,
    );
  }

  CrewHistoryItem _mapHistoryItem(CrewHistoryItemDto dto) {
    return CrewHistoryItem(
      id: dto.id,
      type: dto.type,
      date: dto.date,
      status: dto.status,
      description: dto.description,
      attendanceIn: dto.attendanceIn,
      attendanceOut: dto.attendanceOut,
      overtimeStart: dto.overtimeStart,
      overtimeEnd: dto.overtimeEnd,
    );
  }

  CrewAttendanceHistory _mapCrewHistory(CrewAttendanceHistoryDto dto) {
    return CrewAttendanceHistory(
      totalAttendance: dto.totalAttendance,
      totalLate: dto.totalLate,
      totalLeave: dto.totalLeave,
      totalOvertime: dto.totalOvertime,
      totalOutOfOffice: dto.totalOutOfOffice,
      history: dto.history.map(_mapHistoryItem).toList(),
      attendance: dto.attendance.map(_mapDto).toList(),
    );
  }

  NetworkException _unexpected(String msg) =>
      NetworkException(type: NetworkErrorType.unknown, message: msg);

  // ─────────────────── session helper ───────────────────

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

  // ─────────────────── implementations ───────────────────

  @override
  Future<ApiResponse<List<Attendance>>> getAllAttendance() async {
    final res = await _remote.getAllAttendance();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.items ?? const <AttendanceDto>[];
    return ApiResponse.success(items.map(_mapDto).toList());
  }

  @override
  Future<ApiResponse<AttendanceBasic>> getAttendanceBasic({
    String? date,
  }) async {
    final res = await _remote.getAttendanceBasic(date: date);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final basic = res.data?.basic;
    if (basic == null) {
      // If no attendance record today, return empty basic (not an error)
      return ApiResponse.success(const AttendanceBasic());
    }

    return ApiResponse.success(_mapBasic(basic));
  }

  @override
  Future<ApiResponse<CrewAttendanceHistory>> getCrewAttendanceHistory(
    int userId,
  ) async {
    final res = await _remote.getAttendanceHistory(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final data = res.data?.data;
    if (data == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: crewAttendanceHistory is null'),
      );
    }

    return ApiResponse.success(_mapCrewHistory(data));
  }

  /// Legacy wrapper — used by existing AttendanceController
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

    final data = res.data?.data;
    final attendanceList = data?.attendance ?? const <AttendanceDto>[];
    final mapped = attendanceList.map(_mapDto).toList();

    final presentCount = data?.totalAttendance ?? 0;
    final lateCount = data?.totalLate ?? 0;
    final leaveCount = data?.totalLeave ?? 0;
    final overtimeCount = data?.totalOvertime ?? 0;

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
        _unexpected('Unexpected response: attendanceDetail is null'),
      );
    }

    return ApiResponse.success(_mapDto(dto));
  }

  @override
  Future<ApiResponse<Attendance>> addAttendance(
    AddAttendanceRequest request,
  ) async {
    final res = await _remote.addAttendance(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.attendance;
    if (dto == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: attendanceAdded is null'),
      );
    }

    return ApiResponse.success(_mapDto(dto));
  }

  @override
  Future<ApiResponse<Attendance>> checkIn(CheckInRequest request) async {
    final res = await _remote.checkIn(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.attendance;
    if (dto == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: checkin result is null'),
      );
    }

    // Optionally save the attendance ID from the checkin response if present
    if (dto.id != 0) {
      await _session.saveTodayAttendanceId(dto.id);
    }

    return ApiResponse.success(_mapDto(dto));
  }

  @override
  Future<ApiResponse<Attendance>> checkOut(CheckOutRequest request) async {
    final res = await _remote.checkOut(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.attendance;
    if (dto == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: checkout result is null'),
      );
    }

    return ApiResponse.success(_mapDto(dto));
  }

  @override
  Future<ApiResponse<Attendance>> updateAttendance(
    int attendanceId,
    UpdateAttendanceRequest request,
  ) async {
    final res = await _remote.updateAttendance(attendanceId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.attendance;
    if (dto == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: attendanceUpdated is null'),
      );
    }

    return ApiResponse.success(_mapDto(dto));
  }

  @override
  Future<ApiResponse<int>> deleteAttendance(int id) async {
    final res = await _remote.deleteAttendance(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    // Response key is `attendanceId`
    final deletedId = res.data?.attendanceId ?? id;
    return ApiResponse.success(deletedId);
  }
}
