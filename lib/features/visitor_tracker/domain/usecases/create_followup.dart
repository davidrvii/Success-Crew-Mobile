import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

class CreateFollowUpUseCase {
  final VisitRepository _repo;
  const CreateFollowUpUseCase(this._repo);

  Future<ApiResponse<FollowUp>> call(String visitId, FollowUpRequest request) {
    return _repo.createFollowUp(visitId, request);
  }
}
