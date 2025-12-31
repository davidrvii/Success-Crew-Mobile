import '../../../../core/network/api_response.dart';
import '../../data/models/overtime_request.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

class CreateOvertimeUseCase {
  final OvertimeRepository _repo;
  const CreateOvertimeUseCase(this._repo);

  Future<ApiResponse<Overtime>> call(OvertimeRequest request) =>
      _repo.createOvertime(request);
}
