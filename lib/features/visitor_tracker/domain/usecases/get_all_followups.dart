/// File: lib/features/visitor_tracker/domain/usecases/get_all_followups.dart
/// Generated Documentation for get_all_followups.dart

import '../../../../core/network/api_response.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Get all follow-ups via GET /follow-up/all
/// Class representing `GetAllFollowUpsUseCase`.
/// Auto-generated class documentation.
class GetAllFollowUpsUseCase {
  final VisitRepository _repo;
  const GetAllFollowUpsUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<FollowUp>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<FollowUp>>> call() {
    return _repo.getAllFollowUps();
  }
}
