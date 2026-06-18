import '../../../../core/network/api_response.dart';
import '../../data/models/visitor_request.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

class UpdateVisitorUseCase {
  final VisitRepository _repo;
  const UpdateVisitorUseCase(this._repo);

  Future<ApiResponse<Visitor>> call(int visitorId, VisitorRequest request) {
    return _repo.updateVisitor(visitorId, request);
  }
}
