/// File: lib/features/visitor_tracker/domain/usecases/create_visitor.dart
/// Generated Documentation for create_visitor.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/visitor_request.dart';
import '../entities/visitor.dart';
import '../repositories/visit_repository.dart';

/// Class representing `CreateVisitorUseCase`.
/// Auto-generated class documentation.
class CreateVisitorUseCase {
  final VisitRepository _repo;
  const CreateVisitorUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Visitor>> call(VisitorRequest request) {
    return _repo.createVisitor(request);
  }
}
