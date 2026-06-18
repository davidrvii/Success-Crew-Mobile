import '../../../../core/network/api_response.dart';
import '../entities/overtime_basic_list.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeBasicAllUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeBasicAllUseCase(this._repo);

  Future<ApiResponse<OvertimeBasicList>> call() => _repo.getOvertimeBasicAll();
}
