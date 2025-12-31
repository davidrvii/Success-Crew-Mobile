import '../../../../core/network/api_response.dart';
import '../../data/models/leave_request.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

class CreateLeaveUseCase {
  final LeaveRepository _repo;
  const CreateLeaveUseCase(this._repo);

  Future<ApiResponse<Leave>> call(LeaveRequest request) =>
      _repo.createLeave(request);
}
