/// File: lib/features/auth/domain/usecases/logout_usecase.dart
/// Generated Documentation for logout_usecase.dart

import '../repositories/auth_repository.dart';

/// Class representing `LogoutUseCase`.
/// Auto-generated class documentation.
class LogoutUseCase {
  final AuthRepository _repo;
  const LogoutUseCase(this._repo);

  /// Method `call` returning `Future<void>`.
  /// Handles logic operations related to `call`.
  Future<void> call() => _repo.logout();
}
