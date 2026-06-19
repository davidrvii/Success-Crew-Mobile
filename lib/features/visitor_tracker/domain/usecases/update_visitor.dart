/// File: lib/features/visitor_tracker/domain/usecases/update_visitor.dart
/// Generated Documentation for update_visitor.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/visitor_request.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

/// Class representing `UpdateVisitorUseCase`.
/// Auto-generated class documentation.
class UpdateVisitorUseCase {
  final VisitRepository _repo;
  const UpdateVisitorUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Visitor>> call(int visitorId, VisitorRequest request) {
    return _repo.updateVisitor(visitorId, request);
  }
}
