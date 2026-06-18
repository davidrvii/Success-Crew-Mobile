import '../../../../core/network/api_response.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

class GetVisitorDetailUseCase {
  final VisitRepository _repo;
  const GetVisitorDetailUseCase(this._repo);

  Future<ApiResponse<Visitor>> call(int visitorId) {
    return _repo.getVisitorDetail(visitorId);
  }
}
