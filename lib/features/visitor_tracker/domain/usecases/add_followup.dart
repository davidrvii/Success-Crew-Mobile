import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Add a follow-up via POST /follow-up/add (non-nested, requires visit_id in body)
class AddFollowUpUseCase {
  final VisitRepository _repo;
  const AddFollowUpUseCase(this._repo);

  Future<ApiResponse<FollowUp>> call(FollowUpRequest request) {
    return _repo.addFollowUp(request);
  }
}
