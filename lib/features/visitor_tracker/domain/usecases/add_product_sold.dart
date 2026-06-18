import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

class AddProductSoldUseCase {
  final VisitRepository _repo;
  const AddProductSoldUseCase(this._repo);

  Future<ApiResponse<ProductSold>> call(ProductSoldRequest request) {
    return _repo.addProductSold(request);
  }
}
