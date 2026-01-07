import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

class DeleteFollowUpUseCase {
  final VisitRepository _repo;
  const DeleteFollowUpUseCase(this._repo);

  Future<ApiResponse<int>> call(String visitId, String followUpId) {
    return _repo.deleteFollowUp(visitId, followUpId);
  }
}
