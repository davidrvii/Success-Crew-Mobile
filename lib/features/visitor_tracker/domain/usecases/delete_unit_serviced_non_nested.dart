import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

class DeleteUnitServicedNonNestedUseCase {
  final VisitRepository _repo;
  const DeleteUnitServicedNonNestedUseCase(this._repo);

  Future<ApiResponse<int>> call(int unitServicedId) {
    return _repo.deleteUnitServicedNonNested(unitServicedId);
  }
}
