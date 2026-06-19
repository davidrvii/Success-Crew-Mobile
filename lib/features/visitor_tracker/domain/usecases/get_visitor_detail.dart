/// File: lib/features/visitor_tracker/domain/usecases/get_visitor_detail.dart
/// Generated Documentation for get_visitor_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetVisitorDetailUseCase`.
/// Auto-generated class documentation.
class GetVisitorDetailUseCase {
  final VisitRepository _repo;
  const GetVisitorDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Visitor>> call(int visitorId) {
    return _repo.getVisitorDetail(visitorId);
  }
}
