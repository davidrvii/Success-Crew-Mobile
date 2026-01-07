import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

class DeleteProductSoldUseCase {
  final VisitRepository _repo;
  const DeleteProductSoldUseCase(this._repo);

  Future<ApiResponse<int>> call(String visitId, String productSoldId) {
    return _repo.deleteProductSold(visitId, productSoldId);
  }
}
