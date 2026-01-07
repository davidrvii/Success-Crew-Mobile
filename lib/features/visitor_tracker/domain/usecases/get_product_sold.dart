import '../../../../core/network/api_response.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

class GetProductsSoldUseCase {
  final VisitRepository _repo;
  const GetProductsSoldUseCase(this._repo);

  Future<ApiResponse<List<ProductSold>>> call(String visitId) {
    return _repo.getProductsSold(visitId);
  }
}
