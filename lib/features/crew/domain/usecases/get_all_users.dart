import '../../../../core/network/api_response.dart';
import '../entities/crew_member.dart';
import '../repositories/crew_repository.dart';

class GetAllUsersUseCase {
  final CrewRepository _repo;
  const GetAllUsersUseCase(this._repo);

  Future<ApiResponse<List<CrewMember>>> call() {
    return _repo.getAllUsers();
  }
}
