import '../../../../core/network/api_response.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

class GetAllUnitsServicedUseCase {
  final VisitRepository _repo;
  const GetAllUnitsServicedUseCase(this._repo);

  Future<ApiResponse<List<UnitServiced>>> call() {
    return _repo.getAllUnitsServiced();
  }
}
