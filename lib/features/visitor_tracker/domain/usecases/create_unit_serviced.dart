import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

class CreateUnitServicedUseCase {
  final VisitRepository _repo;
  const CreateUnitServicedUseCase(this._repo);

  Future<ApiResponse<UnitServiced>> call(
    int visitId,
    UnitServicedRequest request,
  ) {
    return _repo.createUnitServiced(visitId, request);
  }
}
