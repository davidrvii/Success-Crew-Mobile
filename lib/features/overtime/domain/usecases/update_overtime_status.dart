import '../../../../core/network/api_response.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

class UpdateOvertimeStatusUseCase {
  final OvertimeRepository _repo;
  const UpdateOvertimeStatusUseCase(this._repo);

  Future<ApiResponse<Overtime>> call(int id, String status) =>
      _repo.updateOvertimeStatus(id, status);
}
