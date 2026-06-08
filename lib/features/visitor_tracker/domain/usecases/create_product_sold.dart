import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

class CreateProductSoldUseCase {
  final VisitRepository _repo;
  const CreateProductSoldUseCase(this._repo);

  Future<ApiResponse<ProductSold>> call(
    int visitId,
    ProductSoldRequest request,
  ) {
    return _repo.createProductSold(visitId, request);
  }
}
