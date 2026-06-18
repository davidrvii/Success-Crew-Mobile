import '../../../../core/network/api_response.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

class GetAllProductsSoldUseCase {
  final VisitRepository _repo;
  const GetAllProductsSoldUseCase(this._repo);

  Future<ApiResponse<List<ProductSold>>> call() {
    return _repo.getAllProductsSold();
  }
}
