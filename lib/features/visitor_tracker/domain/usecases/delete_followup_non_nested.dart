import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Delete a follow-up via DELETE /follow-up/delete/:followUpId (non-nested)
class DeleteFollowUpNonNestedUseCase {
  final VisitRepository _repo;
  const DeleteFollowUpNonNestedUseCase(this._repo);

  Future<ApiResponse<int>> call(int followUpId) {
    return _repo.deleteFollowUpNonNested(followUpId);
  }
}
