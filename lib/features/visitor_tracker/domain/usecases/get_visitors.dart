import '../../../../core/network/api_response.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

class GetVisitorsUseCase {
  final VisitRepository _repo;
  const GetVisitorsUseCase(this._repo);

  Future<ApiResponse<List<Visitor>>> call() {
    return _repo.getVisitors();
  }
}
