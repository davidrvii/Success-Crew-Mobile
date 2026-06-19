/// File: lib/features/visitor_tracker/domain/usecases/delete_unit_serviced.dart
/// Generated Documentation for delete_unit_serviced.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Class representing `DeleteUnitServicedUseCase`.
/// Auto-generated class documentation.
class DeleteUnitServicedUseCase {
  final VisitRepository _repo;
  const DeleteUnitServicedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int visitId, int unitServicedId) {
    return _repo.deleteUnitServiced(visitId, unitServicedId);
  }
}
