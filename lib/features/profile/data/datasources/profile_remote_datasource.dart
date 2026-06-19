/// File: lib/features/profile/data/datasources/profile_remote_datasource.dart
/// Generated Documentation for profile_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/user_basic_model.dart';
import '../models/user_detail_model.dart';
import '../models/update_profile_request.dart';

abstract class ProfileRemoteDataSource {
  /// Method `getUserBasic` returning `Future<ApiResponse<UserBasicResponse>>`.
  /// Handles logic operations related to `getUserBasic`.
  Future<ApiResponse<UserBasicResponse>> getUserBasic(int userId);
  /// Method `getUserDetail` returning `Future<ApiResponse<UserDetailResponse>>`.
  /// Handles logic operations related to `getUserDetail`.
  Future<ApiResponse<UserDetailResponse>> getUserDetail(int userId);

  /// Method `updateProfile` returning `Future<ApiResponse<UserDetailResponse>>`.
  /// Handles logic operations related to `updateProfile`.
  Future<ApiResponse<UserDetailResponse>> updateProfile(
    int userId,
    UpdateProfileRequest request, {
    bool usePut = false,
  });
}

/// Class representing `ProfileRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _client;
  ProfileRemoteDataSourceImpl(this._client);

  @override
  /// Method `getUserBasic` returning `Future<ApiResponse<UserBasicResponse>>`.
  /// Handles logic operations related to `getUserBasic`.
  Future<ApiResponse<UserBasicResponse>> getUserBasic(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userBasic(userId)),
      parser: (json) =>
          UserBasicResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getUserDetail` returning `Future<ApiResponse<UserDetailResponse>>`.
  /// Handles logic operations related to `getUserDetail`.
  Future<ApiResponse<UserDetailResponse>> getUserDetail(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userDetail(userId)),
      parser: (json) =>
          UserDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateProfile` returning `Future<ApiResponse<UserDetailResponse>>`.
  /// Handles logic operations related to `updateProfile`.
  Future<ApiResponse<UserDetailResponse>> updateProfile(
    int userId,
    UpdateProfileRequest request, {
    bool usePut = false,
  }) {
    final hasFile = request.photoFile != null;

    return ApiResponse.guard(
      request: () async {
        if (usePut) {
          if (!hasFile) {
            return _client.put(
              ApiPaths.userUpdate(userId),
              data: request.toJson(),
            );
          }

          final form = await request.toFormData();
          return _client.putMultipart(
            ApiPaths.userUpdate(userId),
            formData: form,
          );
        } else {
          if (!hasFile) {
            return _client.patch(
              ApiPaths.userUpdate(userId),
              data: request.toJson(),
            );
          }

          final form = await request.toFormData();
          return _client.patchMultipart(
            ApiPaths.userUpdate(userId),
            formData: form,
          );
        }
      },
      parser: (json) =>
          UserDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
