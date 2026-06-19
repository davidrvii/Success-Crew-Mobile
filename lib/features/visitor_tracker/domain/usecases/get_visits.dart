/// File: lib/features/visitor_tracker/domain/usecases/get_visits.dart
/// Generated Documentation for get_visits.dart

import '../../../../core/network/api_response.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetVisitsUseCase`.
/// Auto-generated class documentation.
class GetVisitsUseCase {
  final VisitRepository _repo;
  const GetVisitsUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<Visit>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<Visit>>> call() {
    return _repo.getVisitList();
  }
}
