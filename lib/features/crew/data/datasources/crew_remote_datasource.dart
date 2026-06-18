import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';
import '../../../profile/data/models/user_detail_model.dart';
import '../../../attendance/data/models/attendance_model.dart';
import '../models/crew_member_model.dart';

import '../models/crew_request.dart';
import '../models/crew_response.dart';

abstract class CrewRemoteDataSource {
  Future<ApiResponse<CrewListResponse>> getCrewList();
  Future<ApiResponse<CrewListResponse>> getAllUsers();
  Future<ApiResponse<UserDetailResponse>> getCrewDetail(int userId);
  Future<ApiResponse<CrewAttendanceResponse>> getCrewAttendanceHistory(int userId);
  Future<ApiResponse<CrewMutationResponse>> addCrew(CrewRequest request);
  Future<ApiResponse<CrewMutationResponse>> updateCrew(int userId, CrewRequest request);
  Future<ApiResponse<UserDeleteResponse>> deleteUser(int userId);
}

class CrewRemoteDataSourceImpl implements CrewRemoteDataSource {
  final DioClient _client;
  CrewRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<CrewListResponse>> getCrewList() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userCrewAll),
      parser: (json) => CrewListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CrewListResponse>> getAllUsers() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userAll),
      parser: (json) => CrewListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UserDetailResponse>> getCrewDetail(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userCrewDetail(userId)),
      parser: (json) => UserDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CrewAttendanceResponse>> getCrewAttendanceHistory(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceCrew(userId)),
      parser: (json) => CrewAttendanceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CrewMutationResponse>> addCrew(CrewRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.userCrewAdd, data: request.toJson()),
      parser: (json) => CrewMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<CrewMutationResponse>> updateCrew(int userId, CrewRequest request) {
    return ApiResponse.guard(
      request: () => _client.patch(ApiPaths.userCrewUpdate(userId), data: request.toJson()),
      parser: (json) => CrewMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UserDeleteResponse>> deleteUser(int userId) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.userDelete(userId)),
      parser: (json) => UserDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}

