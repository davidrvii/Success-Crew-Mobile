import '../../../../core/network/api_response.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeDetailUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeDetailUseCase(this._repo);

  Future<ApiResponse<Overtime>> call(String id) => _repo.getOvertimeDetail(id);
}
