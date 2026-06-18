import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

class DeleteProductSoldNonNestedUseCase {
  final VisitRepository _repo;
  const DeleteProductSoldNonNestedUseCase(this._repo);

  Future<ApiResponse<int>> call(int productSoldId) {
    return _repo.deleteProductSoldNonNested(productSoldId);
  }
}
