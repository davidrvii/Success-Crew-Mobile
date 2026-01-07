import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

class UpdateUnitServicedUseCase {
  final VisitRepository _repo;
  const UpdateUnitServicedUseCase(this._repo);

  Future<ApiResponse<UnitServiced>> call(
    String visitId,
    String unitServicedId,
    UnitServicedRequest request,
  ) {
    return _repo.updateUnitServiced(visitId, unitServicedId, request);
  }
}
