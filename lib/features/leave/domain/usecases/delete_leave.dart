import '../../../../core/network/api_response.dart';
import '../repositories/leave_repository.dart';

class DeleteLeaveUseCase {
  final LeaveRepository _repo;
  const DeleteLeaveUseCase(this._repo);

  Future<ApiResponse<int>> call(String id) => _repo.deleteLeave(id);
}
