/// File: lib/features/visitor_tracker/domain/usecases/create_unit_serviced.dart
/// Generated Documentation for create_unit_serviced.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

/// Class representing `CreateUnitServicedUseCase`.
/// Auto-generated class documentation.
class CreateUnitServicedUseCase {
  final VisitRepository _repo;
  const CreateUnitServicedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UnitServiced>> call(
    int visitId,
    UnitServicedRequest request,
  ) {
    return _repo.createUnitServiced(visitId, request);
  }
}
