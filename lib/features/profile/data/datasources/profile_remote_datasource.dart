import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/user_basic_model.dart';
import '../models/user_detail_model.dart';
import '../models/update_profile_request.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResponse<UserBasicResponse>> getUserBasic(String userId);
  Future<ApiResponse<UserDetailResponse>> getUserDetail(String userId);

  Future<ApiResponse<UserDetailResponse>> updateProfile(
    String userId,
    UpdateProfileRequest request,
  );
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final DioClient _client;
  ProfileRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<UserBasicResponse>> getUserBasic(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userBasic(userId)),
      parser: (json) =>
          UserBasicResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UserDetailResponse>> getUserDetail(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userDetail(userId)),
      parser: (json) =>
          UserDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UserDetailResponse>> updateProfile(
    String userId,
    UpdateProfileRequest request,
  ) {
    final hasFile = request.photoFile != null;

    return ApiResponse.guard(
      request: () async {
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
      },
      parser: (json) =>
          UserDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
