import '../../../../core/network/api_response.dart';
import '../repositories/crew_repository.dart';

class DeleteUserUseCase {
  final CrewRepository _repo;
  const DeleteUserUseCase(this._repo);

  Future<ApiResponse<int>> call(int userId) {
    return _repo.deleteUser(userId);
  }
}
