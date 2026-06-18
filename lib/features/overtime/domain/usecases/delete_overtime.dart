import '../../../../core/network/api_response.dart';
import '../repositories/overtime_repository.dart';

class DeleteOvertimeUseCase {
  final OvertimeRepository _repo;
  const DeleteOvertimeUseCase(this._repo);

  Future<ApiResponse<int>> call(int id) => _repo.deleteOvertime(id);
}
