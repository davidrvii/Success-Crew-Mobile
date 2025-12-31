import '../../../../core/network/api_response.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

class GetLeaveListUseCase {
  final LeaveRepository _repo;
  const GetLeaveListUseCase(this._repo);

  Future<ApiResponse<List<Leave>>> call() => _repo.getLeaveList();
}
