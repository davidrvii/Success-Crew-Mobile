/// File: lib/features/visitor_tracker/domain/usecases/delete_unit_serviced_non_nested.dart
/// Generated Documentation for delete_unit_serviced_non_nested.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Class representing `DeleteUnitServicedNonNestedUseCase`.
/// Auto-generated class documentation.
class DeleteUnitServicedNonNestedUseCase {
  final VisitRepository _repo;
  const DeleteUnitServicedNonNestedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int unitServicedId) {
    return _repo.deleteUnitServicedNonNested(unitServicedId);
  }
}
