import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

class DeleteVisitorUseCase {
  final VisitRepository _repo;
  const DeleteVisitorUseCase(this._repo);

  Future<ApiResponse<int>> call(int visitorId) {
    return _repo.deleteVisitor(visitorId);
  }
}
