/// File: lib/features/auth/data/datasources/auth_remote_datasource.dart
/// Generated Documentation for auth_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';
import '../models/login_response.dart';
import '../models/register_response.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

abstract class AuthRemoteDataSource {
  /// Method `login` returning `Future<ApiResponse<LoginResponse>>`.
  /// Handles logic operations related to `login`.
  Future<ApiResponse<LoginResponse>> login(LoginRequest request);
  /// Method `register` returning `Future<ApiResponse<RegisterResponse>>`.
  /// Handles logic operations related to `register`.
  Future<ApiResponse<RegisterResponse>> register(RegisterRequest request);
}

/// Class representing `AuthRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _client;

  AuthRemoteDataSourceImpl(this._client);

  @override
  /// Method `login` returning `Future<ApiResponse<LoginResponse>>`.
  /// Handles logic operations related to `login`.
  Future<ApiResponse<LoginResponse>> login(LoginRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.userLogin, data: request.toJson()),
      parser: (json) => LoginResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `register` returning `Future<ApiResponse<RegisterResponse>>`.
  /// Handles logic operations related to `register`.
  Future<ApiResponse<RegisterResponse>> register(RegisterRequest request) {
    return ApiResponse.guard(
      request: () =>
          _client.post(ApiPaths.userRegister, data: request.toJson()),
      parser: (json) => RegisterResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
