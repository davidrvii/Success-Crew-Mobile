import '../../../../core/network/api_response.dart';
import '../../data/models/unit_serviced_request.dart';
import '../entities/unit_serviced.dart';
import '../repositories/visit_repository.dart';

class AddUnitServicedUseCase {
  final VisitRepository _repo;
  const AddUnitServicedUseCase(this._repo);

  Future<ApiResponse<UnitServiced>> call(UnitServicedRequest request) {
    return _repo.addUnitServiced(request);
  }
}
