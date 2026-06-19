/// File: lib/features/visitor_tracker/domain/usecases/get_followup.dart
/// Generated Documentation for get_followup.dart

import '../../../../core/network/api_response.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetFollowUpsUseCase`.
/// Auto-generated class documentation.
class GetFollowUpsUseCase {
  final VisitRepository _repo;
  const GetFollowUpsUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<FollowUp>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<FollowUp>>> call(int visitId) {
    return _repo.getFollowUps(visitId);
  }
}
