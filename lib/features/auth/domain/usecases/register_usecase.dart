/// File: lib/features/auth/domain/usecases/register_usecase.dart
/// Generated Documentation for register_usecase.dart

import '../../../../core/network/api_response.dart';
import '../entities/registered_user.dart';
import '../repositories/auth_repository.dart';

/// Class representing `RegisterUseCase`.
/// Auto-generated class documentation.
class RegisterUseCase {
  final AuthRepository _repo;
  const RegisterUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<RegisteredUser>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<RegisteredUser>> call({
    required int officeId,
    required int roleId,
    required String userName,
    required String userEmail,
    required String userPassword,
  }) {
    return _repo.register(
      officeId: officeId,
      roleId: roleId,
      userName: userName,
      userEmail: userEmail,
      userPassword: userPassword,
    );
  }
}
