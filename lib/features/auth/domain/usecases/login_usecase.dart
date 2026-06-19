/// File: lib/features/auth/domain/usecases/login_usecase.dart
/// Generated Documentation for login_usecase.dart

import '../../../../core/network/api_response.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

/// Class representing `LoginUseCase`.
/// Auto-generated class documentation.
class LoginUseCase {
  final AuthRepository _repo;
  const LoginUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<AuthSession>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AuthSession>> call({
    required String email,
    required String password,
  }) {
    return _repo.login(email: email, password: password);
  }
}
