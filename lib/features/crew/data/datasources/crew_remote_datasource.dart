/// File: lib/features/crew/data/datasources/crew_remote_datasource.dart
/// Generated Documentation for crew_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';
import '../../../profile/data/models/user_detail_model.dart';
import '../../../attendance/data/models/attendance_model.dart';
import '../models/crew_member_model.dart';

import '../models/crew_request.dart';
import '../models/crew_response.dart';

abstract class CrewRemoteDataSource {
  /// Method `getCrewList` returning `Future<ApiResponse<CrewListResponse>>`.
  /// Handles logic operations related to `getCrewList`.
  Future<ApiResponse<CrewListResponse>> getCrewList();
  /// Method `getAllUsers` returning `Future<ApiResponse<CrewListResponse>>`.
  /// Handles logic operations related to `getAllUsers`.
  Future<ApiResponse<CrewListResponse>> getAllUsers();
  /// Method `getCrewDetail` returning `Future<ApiResponse<UserDetailResponse>>`.
  /// Handles logic operations related to `getCrewDetail`.
  Future<ApiResponse<UserDetailResponse>> getCrewDetail(int userId);
  /// Method `getCrewAttendanceHistory` returning `Future<ApiResponse<CrewAttendanceResponse>>`.
  /// Handles logic operations related to `getCrewAttendanceHistory`.
  Future<ApiResponse<CrewAttendanceResponse>> getCrewAttendanceHistory(int userId);
  /// Method `addCrew` returning `Future<ApiResponse<CrewMutationResponse>>`.
  /// Handles logic operations related to `addCrew`.
  Future<ApiResponse<CrewMutationResponse>> addCrew(CrewRequest request);
  /// Method `updateCrew` returning `Future<ApiResponse<CrewMutationResponse>>`.
  /// Handles logic operations related to `updateCrew`.
  Future<ApiResponse<CrewMutationResponse>> updateCrew(int userId, CrewRequest request);
  /// Method `deleteUser` returning `Future<ApiResponse<UserDeleteResponse>>`.
  /// Handles logic operations related to `deleteUser`.
  Future<ApiResponse<UserDeleteResponse>> deleteUser(int userId);
}

/// Class representing `CrewRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class CrewRemoteDataSourceImpl implements CrewRemoteDataSource {
  final DioClient _client;
  CrewRemoteDataSourceImpl(this._client);

  @override
  /// Method `getCrewList` returning `Future<ApiResponse<CrewListResponse>>`.
  /// Handles logic operations related to `getCrewList`.
  Future<ApiResponse<CrewListResponse>> getCrewList() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userCrewAll),
      parser: (json) => CrewListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getAllUsers` returning `Future<ApiResponse<CrewListResponse>>`.
  /// Handles logic operations related to `getAllUsers`.
  Future<ApiResponse<CrewListResponse>> getAllUsers() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userAll),
      parser: (json) => CrewListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getCrewDetail` returning `Future<ApiResponse<UserDetailResponse>>`.
  /// Handles logic operations related to `getCrewDetail`.
  Future<ApiResponse<UserDetailResponse>> getCrewDetail(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userCrewDetail(userId)),
      parser: (json) => UserDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getCrewAttendanceHistory` returning `Future<ApiResponse<CrewAttendanceResponse>>`.
  /// Handles logic operations related to `getCrewAttendanceHistory`.
  Future<ApiResponse<CrewAttendanceResponse>> getCrewAttendanceHistory(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceCrew(userId)),
      parser: (json) => CrewAttendanceResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `addCrew` returning `Future<ApiResponse<CrewMutationResponse>>`.
  /// Handles logic operations related to `addCrew`.
  Future<ApiResponse<CrewMutationResponse>> addCrew(CrewRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.userCrewAdd, data: request.toJson()),
      parser: (json) => CrewMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateCrew` returning `Future<ApiResponse<CrewMutationResponse>>`.
  /// Handles logic operations related to `updateCrew`.
  Future<ApiResponse<CrewMutationResponse>> updateCrew(int userId, CrewRequest request) {
    return ApiResponse.guard(
      request: () => _client.patch(ApiPaths.userCrewUpdate(userId), data: request.toJson()),
      parser: (json) => CrewMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteUser` returning `Future<ApiResponse<UserDeleteResponse>>`.
  /// Handles logic operations related to `deleteUser`.
  Future<ApiResponse<UserDeleteResponse>> deleteUser(int userId) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.userDelete(userId)),
      parser: (json) => UserDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}

