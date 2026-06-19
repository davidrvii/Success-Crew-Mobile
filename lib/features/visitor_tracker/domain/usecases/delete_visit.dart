/// File: lib/features/visitor_tracker/domain/usecases/delete_visit.dart
/// Generated Documentation for delete_visit.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Class representing `DeleteVisitUseCase`.
/// Auto-generated class documentation.
class DeleteVisitUseCase {
  final VisitRepository _repo;
  const DeleteVisitUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int visitId) {
    return _repo.deleteVisit(visitId);
  }
}
