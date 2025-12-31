import '../../../../core/network/api_response.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

class GetOvertimeListUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeListUseCase(this._repo);

  Future<ApiResponse<List<Overtime>>> call() => _repo.getOvertimeList();
}
