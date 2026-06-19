/// File: lib/features/crew/domain/usecases/get_crew_detail.dart
/// Generated Documentation for get_crew_detail.dart

import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../repositories/crew_repository.dart';

/// Class representing `GetCrewDetailUseCase`.
/// Auto-generated class documentation.
class GetCrewDetailUseCase {
  final CrewRepository _repository;
  GetCrewDetailUseCase(this._repository);

  /// Method `call` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UserDetail>> call(int userId) {
    return _repository.getCrewDetail(userId);
  }
}
