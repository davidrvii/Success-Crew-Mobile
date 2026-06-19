/// File: lib/features/visitor_tracker/domain/usecases/get_visitors.dart
/// Generated Documentation for get_visitors.dart

import '../../../../core/network/api_response.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetVisitorsUseCase`.
/// Auto-generated class documentation.
class GetVisitorsUseCase {
  final VisitRepository _repo;
  const GetVisitorsUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<Visitor>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<Visitor>>> call() {
    return _repo.getVisitors();
  }
}
