/// File: lib/features/crew/domain/usecases/get_crew_list.dart
/// Generated Documentation for get_crew_list.dart

import '../../../../core/network/api_response.dart';
import '../entities/crew_member.dart';
import '../repositories/crew_repository.dart';

/// Class representing `GetCrewListUseCase`.
/// Auto-generated class documentation.
class GetCrewListUseCase {
  final CrewRepository _repo;
  const GetCrewListUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<CrewMember>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<CrewMember>>> call() {
    return _repo.getCrewList();
  }
}
