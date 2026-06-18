import '../../../../core/network/api_response.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Get all follow-ups via GET /follow-up/all
class GetAllFollowUpsUseCase {
  final VisitRepository _repo;
  const GetAllFollowUpsUseCase(this._repo);

  Future<ApiResponse<List<FollowUp>>> call() {
    return _repo.getAllFollowUps();
  }
}
