/// File: lib/features/visitor_tracker/domain/usecases/update_product_sold_non_nested.dart
/// Generated Documentation for update_product_sold_non_nested.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

/// Class representing `UpdateProductSoldNonNestedUseCase`.
/// Auto-generated class documentation.
class UpdateProductSoldNonNestedUseCase {
  final VisitRepository _repo;
  const UpdateProductSoldNonNestedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<ProductSold>> call(
    int productSoldId,
    ProductSoldRequest request,
  ) {
    return _repo.updateProductSoldNonNested(productSoldId, request);
  }
}
