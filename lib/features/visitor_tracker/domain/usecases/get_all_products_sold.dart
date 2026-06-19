/// File: lib/features/visitor_tracker/domain/usecases/get_all_products_sold.dart
/// Generated Documentation for get_all_products_sold.dart

import '../../../../core/network/api_response.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetAllProductsSoldUseCase`.
/// Auto-generated class documentation.
class GetAllProductsSoldUseCase {
  final VisitRepository _repo;
  const GetAllProductsSoldUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<ProductSold>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<ProductSold>>> call() {
    return _repo.getAllProductsSold();
  }
}
