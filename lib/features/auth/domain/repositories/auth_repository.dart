/// File: lib/features/auth/domain/repositories/auth_repository.dart
/// Generated Documentation for auth_repository.dart

import '../../../../core/network/api_response.dart';
import '../entities/auth_session.dart';
import '../entities/registered_user.dart';

abstract class AuthRepository {
  /// Method `login` returning `Future<ApiResponse<AuthSession>>`.
  /// Handles logic operations related to `login`.
  Future<ApiResponse<AuthSession>> login({
    required String email,
    required String password,
  });

  /// Method `register` returning `Future<ApiResponse<RegisteredUser>>`.
  /// Handles logic operations related to `register`.
  Future<ApiResponse<RegisteredUser>> register({
    required int officeId,
    required int roleId,
    required String userName,
    required String userEmail,
    required String userPassword,
  });

  /// Method `logout` returning `Future<void>`.
  /// Handles logic operations related to `logout`.
  Future<void> logout();
}
