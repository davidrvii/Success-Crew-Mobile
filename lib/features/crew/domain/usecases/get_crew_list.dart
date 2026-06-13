import '../../../../core/network/api_response.dart';
import '../entities/crew_member.dart';
import '../repositories/crew_repository.dart';

class GetCrewListUseCase {
  final CrewRepository _repo;
  const GetCrewListUseCase(this._repo);

  Future<ApiResponse<List<CrewMember>>> call() {
    return _repo.getCrewList();
  }
}
