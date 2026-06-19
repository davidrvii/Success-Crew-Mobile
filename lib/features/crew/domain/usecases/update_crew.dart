/// File: lib/features/crew/domain/usecases/update_crew.dart
/// Generated Documentation for update_crew.dart

import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../data/models/crew_request.dart';
import '../repositories/crew_repository.dart';

/// Class representing `UpdateCrewUseCase`.
/// Auto-generated class documentation.
class UpdateCrewUseCase {
  final CrewRepository _repo;
  const UpdateCrewUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UserDetail>> call(int userId, CrewRequest request) {
    return _repo.updateCrew(userId, request);
  }
}
