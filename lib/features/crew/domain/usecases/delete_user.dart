/// File: lib/features/crew/domain/usecases/delete_user.dart
/// Generated Documentation for delete_user.dart

import '../../../../core/network/api_response.dart';
import '../repositories/crew_repository.dart';

/// Class representing `DeleteUserUseCase`.
/// Auto-generated class documentation.
class DeleteUserUseCase {
  final CrewRepository _repo;
  const DeleteUserUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int userId) {
    return _repo.deleteUser(userId);
  }
}
