import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

class UpdateProductSoldUseCase {
  final VisitRepository _repo;
  const UpdateProductSoldUseCase(this._repo);

  Future<ApiResponse<ProductSold>> call(
    String visitId,
    String productSoldId,
    ProductSoldRequest request,
  ) {
    return _repo.updateProductSold(visitId, productSoldId, request);
  }
}
