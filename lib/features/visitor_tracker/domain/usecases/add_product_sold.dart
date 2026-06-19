/// File: lib/features/visitor_tracker/domain/usecases/add_product_sold.dart
/// Generated Documentation for add_product_sold.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

/// Class representing `AddProductSoldUseCase`.
/// Auto-generated class documentation.
class AddProductSoldUseCase {
  final VisitRepository _repo;
  const AddProductSoldUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<ProductSold>> call(ProductSoldRequest request) {
    return _repo.addProductSold(request);
  }
}
