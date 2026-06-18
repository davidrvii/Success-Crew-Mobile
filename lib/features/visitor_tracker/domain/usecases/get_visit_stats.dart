import '../../../../core/network/api_response.dart';
import '../entities/visit_stats.dart';
import '../repositories/visit_repository.dart';

class GetVisitStatsUseCase {
  final VisitRepository _repo;
  const GetVisitStatsUseCase(this._repo);

  Future<ApiResponse<VisitStats>> call() {
    return _repo.getVisitStats();
  }
}
