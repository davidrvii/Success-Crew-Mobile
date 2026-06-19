/// File: lib/features/crew/domain/usecases/get_all_users.dart
/// Generated Documentation for get_all_users.dart

import '../../../../core/network/api_response.dart';
import '../entities/crew_member.dart';
import '../repositories/crew_repository.dart';

/// Class representing `GetAllUsersUseCase`.
/// Auto-generated class documentation.
class GetAllUsersUseCase {
  final CrewRepository _repo;
  const GetAllUsersUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<CrewMember>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<CrewMember>>> call() {
    return _repo.getAllUsers();
  }
}
