import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../data/models/crew_request.dart';
import '../repositories/crew_repository.dart';

class AddCrewUseCase {
  final CrewRepository _repo;
  const AddCrewUseCase(this._repo);

  Future<ApiResponse<UserDetail>> call(CrewRequest request) {
    return _repo.addCrew(request);
  }
}
