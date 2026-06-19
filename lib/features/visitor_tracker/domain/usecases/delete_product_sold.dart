/// File: lib/features/visitor_tracker/domain/usecases/delete_product_sold.dart
/// Generated Documentation for delete_product_sold.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Class representing `DeleteProductSoldUseCase`.
/// Auto-generated class documentation.
class DeleteProductSoldUseCase {
  final VisitRepository _repo;
  const DeleteProductSoldUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int visitId, int productSoldId) {
    return _repo.deleteProductSold(visitId, productSoldId);
  }
}
