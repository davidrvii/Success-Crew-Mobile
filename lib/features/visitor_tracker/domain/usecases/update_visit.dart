/// File: lib/features/visitor_tracker/domain/usecases/update_visit.dart
/// Generated Documentation for update_visit.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/visit_request.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

/// Class representing `UpdateVisitUseCase`.
/// Auto-generated class documentation.
class UpdateVisitUseCase {
  final VisitRepository _repo;
  const UpdateVisitUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Visit>> call(int visitId, VisitRequest request) {
    return _repo.updateVisit(visitId, request);
  }
}
