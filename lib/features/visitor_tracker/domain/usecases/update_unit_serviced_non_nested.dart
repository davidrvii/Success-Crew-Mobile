/// File: lib/features/visitor_tracker/domain/usecases/update_unit_serviced_non_nested.dart
/// Generated Documentation for update_unit_serviced_non_nested.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

/// Class representing `UpdateUnitServicedNonNestedUseCase`.
/// Auto-generated class documentation.
class UpdateUnitServicedNonNestedUseCase {
  final VisitRepository _repo;
  const UpdateUnitServicedNonNestedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UnitServiced>> call(
    int unitServicedId,
    UnitServicedRequest request,
  ) {
    return _repo.updateUnitServicedNonNested(unitServicedId, request);
  }
}
