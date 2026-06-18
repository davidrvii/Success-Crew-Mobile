import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

class UpdateProductSoldNonNestedUseCase {
  final VisitRepository _repo;
  const UpdateProductSoldNonNestedUseCase(this._repo);

  Future<ApiResponse<ProductSold>> call(
    int productSoldId,
    ProductSoldRequest request,
  ) {
    return _repo.updateProductSoldNonNested(productSoldId, request);
  }
}
