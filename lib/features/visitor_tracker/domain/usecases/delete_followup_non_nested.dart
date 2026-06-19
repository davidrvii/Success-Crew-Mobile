/// File: lib/features/visitor_tracker/domain/usecases/delete_followup_non_nested.dart
/// Generated Documentation for delete_followup_non_nested.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Delete a follow-up via DELETE /follow-up/delete/:followUpId (non-nested)
/// Class representing `DeleteFollowUpNonNestedUseCase`.
/// Auto-generated class documentation.
class DeleteFollowUpNonNestedUseCase {
  final VisitRepository _repo;
  const DeleteFollowUpNonNestedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int followUpId) {
    return _repo.deleteFollowUpNonNested(followUpId);
  }
}
