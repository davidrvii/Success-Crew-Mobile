/// File: lib/features/leave/data/datasources/leave_remote_datasource.dart
/// Generated Documentation for leave_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/leave_model.dart';
import '../models/leave_request.dart';

abstract class LeaveRemoteDataSource {
  /// Method `getLeaveList` returning `Future<ApiResponse<LeaveListResponse>>`.
  /// Handles logic operations related to `getLeaveList`.
  Future<ApiResponse<LeaveListResponse>> getLeaveList(int userId);
  /// Method `getLeaveDetail` returning `Future<ApiResponse<LeaveDetailResponse>>`.
  /// Handles logic operations related to `getLeaveDetail`.
  Future<ApiResponse<LeaveDetailResponse>> getLeaveDetail(int id);

  /// Method `createLeave` returning `Future<ApiResponse<CreateLeaveResponse>>`.
  /// Handles logic operations related to `createLeave`.
  Future<ApiResponse<CreateLeaveResponse>> createLeave(LeaveRequest request);
  /// Method `updateLeave` returning `Future<ApiResponse<UpdateLeaveResponse>>`.
  /// Handles logic operations related to `updateLeave`.
  Future<ApiResponse<UpdateLeaveResponse>> updateLeave(
    int id,
    LeaveRequest request,
  );

  /// Method `deleteLeave` returning `Future<ApiResponse<DeleteLeaveResponse>>`.
  /// Handles logic operations related to `deleteLeave`.
  Future<ApiResponse<DeleteLeaveResponse>> deleteLeave(int id);

  /// Method `getAllLeave` returning `Future<ApiResponse<LeaveListResponse>>`.
  /// Handles logic operations related to `getAllLeave`.
  Future<ApiResponse<LeaveListResponse>> getAllLeave();
}

/// Class representing `LeaveRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final DioClient _client;
  LeaveRemoteDataSourceImpl(this._client);

  @override
  /// Method `getLeaveList` returning `Future<ApiResponse<LeaveListResponse>>`.
  /// Handles logic operations related to `getLeaveList`.
  Future<ApiResponse<LeaveListResponse>> getLeaveList(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.leaveCrew(userId)),
      parser: (json) =>
          LeaveListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getLeaveDetail` returning `Future<ApiResponse<LeaveDetailResponse>>`.
  /// Handles logic operations related to `getLeaveDetail`.
  Future<ApiResponse<LeaveDetailResponse>> getLeaveDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.leaveDetail(id)),
      parser: (json) =>
          LeaveDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createLeave` returning `Future<ApiResponse<CreateLeaveResponse>>`.
  /// Handles logic operations related to `createLeave`.
  Future<ApiResponse<CreateLeaveResponse>> createLeave(LeaveRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.leaveAdd, data: request.toJson()),
      parser: (json) =>
          CreateLeaveResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateLeave` returning `Future<ApiResponse<UpdateLeaveResponse>>`.
  /// Handles logic operations related to `updateLeave`.
  Future<ApiResponse<UpdateLeaveResponse>> updateLeave(
    int id,
    LeaveRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.patch(ApiPaths.leaveUpdate(id), data: request.toJson()),
      parser: (json) =>
          UpdateLeaveResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteLeave` returning `Future<ApiResponse<DeleteLeaveResponse>>`.
  /// Handles logic operations related to `deleteLeave`.
  Future<ApiResponse<DeleteLeaveResponse>> deleteLeave(int id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.leaveDelete(id)),
      parser: (json) =>
          DeleteLeaveResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getAllLeave` returning `Future<ApiResponse<LeaveListResponse>>`.
  /// Handles logic operations related to `getAllLeave`.
  Future<ApiResponse<LeaveListResponse>> getAllLeave() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.leaveAll),
      parser: (json) =>
          LeaveListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
