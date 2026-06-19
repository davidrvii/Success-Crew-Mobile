/// File: lib/features/visitor_tracker/domain/usecases/get_product_sold.dart
/// Generated Documentation for get_product_sold.dart

import '../../../../core/network/api_response.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetProductsSoldUseCase`.
/// Auto-generated class documentation.
class GetProductsSoldUseCase {
  final VisitRepository _repo;
  const GetProductsSoldUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<ProductSold>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<ProductSold>>> call(int visitId) {
    return _repo.getProductsSold(visitId);
  }
}
