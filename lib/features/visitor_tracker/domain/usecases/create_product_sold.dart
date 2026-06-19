/// File: lib/features/visitor_tracker/domain/usecases/create_product_sold.dart
/// Generated Documentation for create_product_sold.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/product_sold_request.dart';
import '../entities/product_sold.dart';
import '../repositories/visit_repository.dart';

/// Class representing `CreateProductSoldUseCase`.
/// Auto-generated class documentation.
class CreateProductSoldUseCase {
  final VisitRepository _repo;
  const CreateProductSoldUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<ProductSold>> call(
    int visitId,
    ProductSoldRequest request,
  ) {
    return _repo.createProductSold(visitId, request);
  }
}
