import '../../../../core/network/api_response.dart';
import '../entities/overtime_basic.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeBasicDetailUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeBasicDetailUseCase(this._repo);

  Future<ApiResponse<OvertimeBasic>> call(int id) => _repo.getOvertimeBasicDetail(id);
}
