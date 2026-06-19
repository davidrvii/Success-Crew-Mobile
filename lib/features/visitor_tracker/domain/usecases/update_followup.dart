/// File: lib/features/visitor_tracker/domain/usecases/update_followup.dart
/// Generated Documentation for update_followup.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Class representing `UpdateFollowUpUseCase`.
/// Auto-generated class documentation.
class UpdateFollowUpUseCase {
  final VisitRepository _repo;
  const UpdateFollowUpUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<FollowUp>> call(
    int visitId,
    int followUpId,
    FollowUpRequest request,
  ) {
    return _repo.updateFollowUp(visitId, followUpId, request);
  }
}
