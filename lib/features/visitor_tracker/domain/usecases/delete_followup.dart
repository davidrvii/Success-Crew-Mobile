/// File: lib/features/visitor_tracker/domain/usecases/delete_followup.dart
/// Generated Documentation for delete_followup.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Class representing `DeleteFollowUpUseCase`.
/// Auto-generated class documentation.
class DeleteFollowUpUseCase {
  final VisitRepository _repo;
  const DeleteFollowUpUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int visitId, int followUpId) {
    return _repo.deleteFollowUp(visitId, followUpId);
  }
}
