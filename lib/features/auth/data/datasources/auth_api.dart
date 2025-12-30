import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

abstract class AuthRemoteDataSource {
  Future<ApiResponse<LoginResponse>> login(LoginRequest request);
  Future<ApiResponse<RegisterResponse>> register(RegisterRequest request);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<LoginResponse>> login(LoginRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.userLogin, data: request.toJson()),
      parser: (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<RegisterResponse>> register(RegisterRequest request) {
    return ApiResponse.guard(
      request: () =>
          _client.post(ApiPaths.userRegister, data: request.toJson()),
      parser: (json) => RegisterResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
