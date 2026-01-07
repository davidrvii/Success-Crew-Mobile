import '../../../../core/network/api_response.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

class GetUnitsServicedUseCase {
  final VisitRepository _repo;
  const GetUnitsServicedUseCase(this._repo);

  Future<ApiResponse<List<UnitServiced>>> call(String visitId) {
    return _repo.getUnitsServiced(visitId);
  }
}
