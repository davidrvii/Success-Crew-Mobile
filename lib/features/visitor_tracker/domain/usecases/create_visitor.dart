import '../../../../core/network/api_response.dart';
import '../../data/models/visitor_request.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

class CreateVisitorUseCase {
  final VisitRepository _repo;
  const CreateVisitorUseCase(this._repo);

  Future<ApiResponse<Visitor>> call(VisitorRequest request) {
    return _repo.createVisitor(request);
  }
}
