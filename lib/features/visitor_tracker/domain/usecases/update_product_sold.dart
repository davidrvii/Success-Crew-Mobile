/// File: lib/features/visitor_tracker/domain/usecases/update_product_sold.dart
/// Generated Documentation for update_product_sold.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

/// Class representing `UpdateProductSoldUseCase`.
/// Auto-generated class documentation.
class UpdateProductSoldUseCase {
  final VisitRepository _repo;
  const UpdateProductSoldUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<ProductSold>> call(
    int visitId,
    int productSoldId,
    ProductSoldRequest request,
  ) {
    return _repo.updateProductSold(visitId, productSoldId, request);
  }
}
