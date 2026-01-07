import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

class DeleteUnitServicedUseCase {
  final VisitRepository _repo;
  const DeleteUnitServicedUseCase(this._repo);

  Future<ApiResponse<int>> call(String visitId, String unitServicedId) {
    return _repo.deleteUnitServiced(visitId, unitServicedId);
  }
}
