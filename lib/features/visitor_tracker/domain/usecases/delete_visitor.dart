/// File: lib/features/visitor_tracker/domain/usecases/delete_visitor.dart
/// Generated Documentation for delete_visitor.dart

import '../../../../core/network/api_response.dart';
import '../repositories/visit_repository.dart';

/// Class representing `DeleteVisitorUseCase`.
/// Auto-generated class documentation.
class DeleteVisitorUseCase {
  final VisitRepository _repo;
  const DeleteVisitorUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int visitorId) {
    return _repo.deleteVisitor(visitorId);
  }
}
