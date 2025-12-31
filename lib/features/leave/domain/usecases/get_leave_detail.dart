import '../../../../core/network/api_response.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

class GetLeaveDetailUseCase {
  final LeaveRepository _repo;
  const GetLeaveDetailUseCase(this._repo);

  Future<ApiResponse<Leave>> call(String id) => _repo.getLeaveDetail(id);
}
