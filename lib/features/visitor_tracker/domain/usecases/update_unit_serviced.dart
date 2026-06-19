/// File: lib/features/visitor_tracker/domain/usecases/update_unit_serviced.dart
/// Generated Documentation for update_unit_serviced.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

/// Class representing `UpdateUnitServicedUseCase`.
/// Auto-generated class documentation.
class UpdateUnitServicedUseCase {
  final VisitRepository _repo;
  const UpdateUnitServicedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UnitServiced>> call(
    int visitId,
    int unitServicedId,
    UnitServicedRequest request,
  ) {
    return _repo.updateUnitServiced(visitId, unitServicedId, request);
  }
}
