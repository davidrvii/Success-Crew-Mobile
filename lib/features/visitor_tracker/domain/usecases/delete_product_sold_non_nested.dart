/// File: lib/features/visitor_tracker/domain/usecases/delete_product_sold_non_nested.dart
/// Generated Documentation for delete_product_sold_non_nested.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Class representing `DeleteProductSoldNonNestedUseCase`.
/// Auto-generated class documentation.
class DeleteProductSoldNonNestedUseCase {
  final VisitRepository _repo;
  const DeleteProductSoldNonNestedUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int productSoldId) {
    return _repo.deleteProductSoldNonNested(productSoldId);
  }
}
