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

    final data = res.data?.data;
    final items = data?.attendance ?? const <AttendanceDto>[];
    final mapped = items.map(_mapDtoToEntity).toList();

    return ApiResponse.success(
      AttendanceHistoryData(
        history: mapped,
        presentCount: data?.totalAttendance ?? 0,
        lateCount: data?.totalLate ?? 0,
        leaveCount: data?.totalLeave ?? 0,
        overtimeCount: data?.totalOvertime ?? 0,
        outOfOfficeCount: data?.totalOutOfOffice ?? 0,
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
