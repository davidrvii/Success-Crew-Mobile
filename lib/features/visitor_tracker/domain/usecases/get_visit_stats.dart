/// File: lib/features/visitor_tracker/domain/usecases/get_visit_stats.dart
/// Generated Documentation for get_visit_stats.dart

import '../../../../core/network/api_response.dart';
import '../entities/visit_stats.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetVisitStatsUseCase`.
/// Auto-generated class documentation.
class GetVisitStatsUseCase {
  final VisitRepository _repo;
  const GetVisitStatsUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<VisitStats>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<VisitStats>> call() {
    return _repo.getVisitStats();
  }
}
