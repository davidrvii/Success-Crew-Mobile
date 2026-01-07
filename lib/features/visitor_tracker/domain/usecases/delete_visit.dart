import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

class DeleteVisitUseCase {
  final VisitRepository _repo;
  const DeleteVisitUseCase(this._repo);

  Future<ApiResponse<int>> call(String visitId) {
    return _repo.deleteVisit(visitId);
  }
}
