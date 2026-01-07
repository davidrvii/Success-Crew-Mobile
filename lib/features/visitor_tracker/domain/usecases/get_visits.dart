import '../../../../core/network/api_response.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class GetVisitsUseCase {
  final VisitRepository _repo;
  const GetVisitsUseCase(this._repo);

  Future<ApiResponse<List<Visit>>> call() {
    return _repo.getAdminVisits();
  }
}
