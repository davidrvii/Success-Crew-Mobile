/// File: lib/features/visitor_tracker/domain/usecases/add_unit_serviced.dart
/// Generated Documentation for add_unit_serviced.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

/// Class representing `AddUnitServicedUseCase`.
/// Auto-generated class documentation.
class AddUnitServicedUseCase {
  final VisitRepository _repo;
  const AddUnitServicedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UnitServiced>> call(UnitServicedRequest request) {
    return _repo.addUnitServiced(request);
  }
}
