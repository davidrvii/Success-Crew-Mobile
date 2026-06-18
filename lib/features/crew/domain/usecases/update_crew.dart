import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../data/models/crew_request.dart';
import '../repositories/crew_repository.dart';

class UpdateCrewUseCase {
  final CrewRepository _repo;
  const UpdateCrewUseCase(this._repo);

  Future<ApiResponse<UserDetail>> call(int userId, CrewRequest request) {
    return _repo.updateCrew(userId, request);
  }
}
