/// File: lib/features/leave/data/repositories/leave_repository_impl.dart
/// Generated Documentation for leave_repository_impl.dart

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/leave.dart';
import '../../domain/repositories/leave_repository.dart';

import '../datasources/leave_remote_datasource.dart';
import '../models/leave_model.dart';
import '../models/leave_request.dart';

/// Class representing `LeaveRepositoryImpl`.
/// Auto-generated class documentation.
class LeaveRepositoryImpl implements LeaveRepository {
  final LeaveRemoteDataSource _remote;
  final UserSession _session;

  LeaveRepositoryImpl(this._remote, this._session);

  @override
  /// Method `getLeaveList` returning `Future<ApiResponse<List<Leave>>>`.
  /// Handles logic operations related to `getLeaveList`.
  Future<ApiResponse<List<Leave>>> getLeaveList() async {
    final session = await _session.readSession();
    final roleName = (session?['role_name'] as String?)?.trim().toLowerCase();
    final isOwner = roleName == 'owner';

    final ApiResponse<LeaveListResponse> res;
    if (isOwner) {
      res = await _remote.getAllLeave();
    } else {
      final userIdRes = await _requireUserId();
      if (!userIdRes.isSuccess) return ApiResponse.failure(userIdRes.error!);
      final int userId = userIdRes.data!;
      res = await _remote.getLeaveList(userId);
    }

    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.items ?? const <LeaveDto>[];
    return ApiResponse.success(items.map(_mapDtoToEntity).toList());
  }

  @override
  /// Method `getLeaveDetail` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `getLeaveDetail`.
  Future<ApiResponse<Leave>> getLeaveDetail(int id) async {
    final res = await _remote.getLeaveDetail(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.detail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (leave detail is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  /// Method `createLeave` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `createLeave`.
  Future<ApiResponse<Leave>> createLeave(LeaveRequest request) async {
    final ensured = await _ensureUserIdInRequest(request);

    final res = await _remote.createLeave(ensured);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.leave;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected create response (leave is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  /// Method `updateLeave` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `updateLeave`.
  Future<ApiResponse<Leave>> updateLeave(int id, LeaveRequest request) async {
    final ensured = await _ensureUserIdInRequest(request);

    final res = await _remote.updateLeave(id, ensured);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.leave;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected update response (leave is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  /// Method `deleteLeave` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteLeave`.
  Future<ApiResponse<int>> deleteLeave(int id) async {
    final res = await _remote.deleteLeave(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final deletedId = res.data?.leaveId;
    if (deletedId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected delete response (leaveId is null).',
        ),
      );
    }

    return ApiResponse.success(deletedId);
  }

  // ========= helpers =========

  /// Method `_requireUserId` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `_requireUserId`.
  Future<ApiResponse<int>> _requireUserId() async {
    final int? userId = await _session.readUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }
    return ApiResponse.success(userId);
  }

  /// Method `_ensureUserIdInRequest` returning `Future<LeaveRequest>`.
  /// Handles logic operations related to `_ensureUserIdInRequest`.
  Future<LeaveRequest> _ensureUserIdInRequest(LeaveRequest req) async {
    if (req.userId != null) return req;

    final userIdRes = await _requireUserId();
    if (!userIdRes.isSuccess) {
      return req;
    }

    final int userId = userIdRes.data!;

    return LeaveRequest(
      userId: userId,
      leaveType: req.leaveType,
      startDate: req.startDate,
      endDate: req.endDate,
      reason: req.reason,
      status: req.status,
    );
  }

  Leave _mapDtoToEntity(LeaveDto dto) {
    return Leave(
      id: dto.id,
      userId: dto.userId,
      leaveType: dto.leaveType,
      startDate: dto.startDate,
      endDate: dto.endDate,
      reason: dto.reason,
      status: dto.status,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      userName: dto.userName,
    );
  }
}
