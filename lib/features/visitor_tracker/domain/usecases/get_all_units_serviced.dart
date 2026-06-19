/// File: lib/features/visitor_tracker/domain/usecases/get_all_units_serviced.dart
/// Generated Documentation for get_all_units_serviced.dart

import '../../../../core/network/api_response.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetAllUnitsServicedUseCase`.
/// Auto-generated class documentation.
class GetAllUnitsServicedUseCase {
  final VisitRepository _repo;
  const GetAllUnitsServicedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<UnitServiced>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<UnitServiced>>> call() {
    return _repo.getAllUnitsServiced();
  }
}
