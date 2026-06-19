/// File: lib/features/crew/domain/usecases/add_crew.dart
/// Generated Documentation for add_crew.dart

import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../data/models/crew_request.dart';
import '../repositories/crew_repository.dart';

/// Class representing `AddCrewUseCase`.
/// Auto-generated class documentation.
class AddCrewUseCase {
  final CrewRepository _repo;
  const AddCrewUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UserDetail>> call(CrewRequest request) {
    return _repo.addCrew(request);
  }
}
