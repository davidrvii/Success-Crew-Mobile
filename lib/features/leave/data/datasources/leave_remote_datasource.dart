import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/leave_model.dart';
import '../models/leave_request.dart';

abstract class LeaveRemoteDataSource {
  Future<ApiResponse<LeaveListResponse>> getLeaveList(String userId);
  Future<ApiResponse<LeaveDetailResponse>> getLeaveDetail(String id);

  Future<ApiResponse<CreateLeaveResponse>> createLeave(LeaveRequest request);
  Future<ApiResponse<UpdateLeaveResponse>> updateLeave(
    String id,
    LeaveRequest request,
  );

  Future<ApiResponse<DeleteLeaveResponse>> deleteLeave(String id);

  Future<ApiResponse<LeaveListResponse>> getAllLeaveAdmin();
}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final DioClient _client;
  LeaveRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<LeaveListResponse>> getLeaveList(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.leaveCrew(userId)),
      parser: (json) =>
          LeaveListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<LeaveDetailResponse>> getLeaveDetail(String id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.leaveDetail(id)),
      parser: (json) =>
          LeaveDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CreateLeaveResponse>> createLeave(LeaveRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.leaveAdd, data: request.toJson()),
      parser: (json) =>
          CreateLeaveResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UpdateLeaveResponse>> updateLeave(
    String id,
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
  Future<ApiResponse<DeleteLeaveResponse>> deleteLeave(String id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.leaveDelete(id)),
      parser: (json) =>
          DeleteLeaveResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<LeaveListResponse>> getAllLeaveAdmin() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.leaveAdmin),
      parser: (json) =>
          LeaveListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
