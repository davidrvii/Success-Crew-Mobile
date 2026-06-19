/// File: lib/features/visitor_tracker/domain/usecases/update_followup_non_nested.dart
/// Generated Documentation for update_followup_non_nested.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Update a follow-up via PUT /follow-up/update/:followUpId (non-nested)
/// Class representing `UpdateFollowUpNonNestedUseCase`.
/// Auto-generated class documentation.
class UpdateFollowUpNonNestedUseCase {
  final VisitRepository _repo;
  const UpdateFollowUpNonNestedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<FollowUp>> call(int followUpId, FollowUpRequest request) {
    return _repo.updateFollowUpNonNested(followUpId, request);
  }
}
