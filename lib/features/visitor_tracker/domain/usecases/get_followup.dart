import '../../../../core/network/api_response.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

class GetFollowUpsUseCase {
  final VisitRepository _repo;
  const GetFollowUpsUseCase(this._repo);

  Future<ApiResponse<List<FollowUp>>> call(String visitId) {
    return _repo.getFollowUps(visitId);
  }
}
