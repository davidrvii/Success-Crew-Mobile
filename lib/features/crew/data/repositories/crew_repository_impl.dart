/// File: lib/features/crew/data/repositories/crew_repository_impl.dart
/// Generated Documentation for crew_repository_impl.dart

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../profile/data/models/user_detail_model.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../../attendance/data/models/attendance_model.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../../domain/entities/crew_member.dart';
import '../../domain/repositories/crew_repository.dart';
import '../datasources/crew_remote_datasource.dart';
import '../models/crew_member_model.dart';
import '../models/crew_request.dart';

/// Class representing `CrewRepositoryImpl`.
/// Auto-generated class documentation.
class CrewRepositoryImpl implements CrewRepository {
  final CrewRemoteDataSource _remote;
  CrewRepositoryImpl(this._remote);

  @override
  /// Method `getCrewList` returning `Future<ApiResponse<List<CrewMember>>>`.
  /// Handles logic operations related to `getCrewList`.
  Future<ApiResponse<List<CrewMember>>> getCrewList() async {
    final res = await _remote.getCrewList();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.users ?? const <CrewMemberDto>[];
    final mapped = items.map((dto) => CrewMember(
      userId: dto.userId,
      userName: dto.userName,
      userEmail: dto.userEmail,
      userPhoto: dto.userPhoto,
      roleName: dto.roleName,
      officeName: dto.officeName,
    )).toList();

    return ApiResponse.success(mapped);
  }

  @override
  /// Method `getCrewDetail` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `getCrewDetail`.
  Future<ApiResponse<UserDetail>> getCrewDetail(int userId) async {
    final res = await _remote.getCrewDetail(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.userDetail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (userDetail is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDetail(dto));
  }

  @override
  /// Method `getCrewAttendanceHistory` returning `Future<ApiResponse<AttendanceHistoryData>>`.
  /// Handles logic operations related to `getCrewAttendanceHistory`.
  Future<ApiResponse<AttendanceHistoryData>> getCrewAttendanceHistory(int userId) async {
    final res = await _remote.getCrewAttendanceHistory(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.data?.attendance ?? const <AttendanceDto>[];
    final mapped = items.map(_mapDtoToEntity).toList();

    // Calculate stats filtered by the current calendar year
    final now = DateTime.now();
    final currentYear = now.year;

    final currentYearEntries = mapped.where((a) {
      if (a.attendanceDate == null) return false;
      return a.attendanceDate!.toLocal().year == currentYear;
    }).toList();

    final actualPresentCount = currentYearEntries.where((a) {
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

    int leaveCount = 0;
    int outOfOfficeCount = 0;

    final historyList = res.data?.data?.history;
    if (historyList != null) {
      for (final h in historyList) {
        if (h.date != null && h.date!.toLocal().year == currentYear) {
          final statusLower = (h.status ?? '').toLowerCase().trim();
          final isApproved = statusLower == 'approved' || statusLower == 'diterima';
          if (isApproved) {
            if (h.type == 'leave') {
              leaveCount++;
            } else if (h.type == 'out_of_office') {
              outOfOfficeCount++;
            }
          }
        }
      }
    }

    final presentCount = actualPresentCount + outOfOfficeCount;

    return ApiResponse.success(
      AttendanceHistoryData(
        history: mapped,
        presentCount: presentCount,
        lateCount: lateCount,
        leaveCount: leaveCount,
        overtimeCount: overtimeCount,
        outOfOfficeCount: outOfOfficeCount,
      ),
    );
  }

  @override
  /// Method `getAllUsers` returning `Future<ApiResponse<List<CrewMember>>>`.
  /// Handles logic operations related to `getAllUsers`.
  Future<ApiResponse<List<CrewMember>>> getAllUsers() async {
    final res = await _remote.getAllUsers();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.users ?? const <CrewMemberDto>[];
    final mapped = items.map((dto) => CrewMember(
      userId: dto.userId,
      userName: dto.userName,
      userEmail: dto.userEmail,
      userPhoto: dto.userPhoto,
      roleName: dto.roleName,
      officeName: dto.officeName,
    )).toList();

    return ApiResponse.success(mapped);
  }

  @override
  /// Method `addCrew` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `addCrew`.
  Future<ApiResponse<UserDetail>> addCrew(CrewRequest request) async {
    final res = await _remote.addCrew(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.user;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (user is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDetail(dto));
  }

  @override
  /// Method `updateCrew` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `updateCrew`.
  Future<ApiResponse<UserDetail>> updateCrew(int userId, CrewRequest request) async {
    final res = await _remote.updateCrew(userId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.user;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (user is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDetail(dto));
  }

  @override
  /// Method `deleteUser` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteUser`.
  Future<ApiResponse<int>> deleteUser(int userId) async {
    final res = await _remote.deleteUser(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final deletedId = res.data?.userId ?? userId;
    return ApiResponse.success(deletedId);
  }

  UserDetail _mapDetail(UserDetailDto dto) {
    return UserDetail(
      userId: dto.userId,
      officeId: dto.officeId,
      roleId: dto.roleId,
      userName: dto.userName,
      userEmail: dto.userEmail,
      userPhoto: dto.userPhoto,
      roleName: dto.roleName,
      officeName: dto.officeName,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      crewStatus: dto.crewStatus,
      contractStatus: dto.contractStatus,
      userPhone: dto.userPhone,
      userBirth: dto.userBirth,
      startWork: dto.startWork,
      endWork: dto.endWork,
      totalAttendance: dto.totalAttendance,
      totalLate: dto.totalLate,
      totalLeave: dto.totalLeave,
      totalOvertime: dto.totalOvertime,
      totalOutOfOffice: dto.totalOutOfOffice,
      history: dto.history?.map((h) => CrewHistory(
        id: h.id,
        type: h.type,
        date: h.date,
        status: h.status,
        description: h.description,
        details: h.details,
      )).toList(),
    );
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
