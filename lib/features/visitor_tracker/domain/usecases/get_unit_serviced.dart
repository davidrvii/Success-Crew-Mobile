/// File: lib/features/visitor_tracker/domain/usecases/get_unit_serviced.dart
/// Generated Documentation for get_unit_serviced.dart

import '../../../../core/network/api_response.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetUnitsServicedUseCase`.
/// Auto-generated class documentation.
class GetUnitsServicedUseCase {
  final VisitRepository _repo;
  const GetUnitsServicedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<UnitServiced>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<UnitServiced>>> call(int visitId) {
    return _repo.getUnitsServiced(visitId);
  }
}
