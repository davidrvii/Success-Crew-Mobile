import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

class UpdateUnitServicedNonNestedUseCase {
  final VisitRepository _repo;
  const UpdateUnitServicedNonNestedUseCase(this._repo);

  Future<ApiResponse<UnitServiced>> call(
    int unitServicedId,
    UnitServicedRequest request,
  ) {
    return _repo.updateUnitServicedNonNested(unitServicedId, request);
  }
}
