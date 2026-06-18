import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Update a follow-up via PUT /follow-up/update/:followUpId (non-nested)
class UpdateFollowUpNonNestedUseCase {
  final VisitRepository _repo;
  const UpdateFollowUpNonNestedUseCase(this._repo);

  Future<ApiResponse<FollowUp>> call(int followUpId, FollowUpRequest request) {
    return _repo.updateFollowUpNonNested(followUpId, request);
  }
}
