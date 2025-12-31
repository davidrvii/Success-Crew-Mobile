import '../../../../core/network/api_response.dart';
import '../../data/models/overtime_request.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

class UpdateOvertimeUseCase {
  final OvertimeRepository _repo;
  const UpdateOvertimeUseCase(this._repo);

  Future<ApiResponse<Overtime>> call(String id, OvertimeRequest request) =>
      _repo.updateOvertime(id, request);
}
