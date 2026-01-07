import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

class UpdateFollowUpUseCase {
  final VisitRepository _repo;
  const UpdateFollowUpUseCase(this._repo);

  Future<ApiResponse<FollowUp>> call(
    String visitId,
    String followUpId,
    FollowUpRequest request,
  ) {
    return _repo.updateFollowUp(visitId, followUpId, request);
  }
}
