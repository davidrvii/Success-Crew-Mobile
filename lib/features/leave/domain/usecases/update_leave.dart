import '../../../../core/network/api_response.dart';
import '../../data/models/leave_request.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

class UpdateLeaveUseCase {
  final LeaveRepository _repo;
  const UpdateLeaveUseCase(this._repo);

  Future<ApiResponse<Leave>> call(String id, LeaveRequest request) =>
      _repo.updateLeave(id, request);
}
