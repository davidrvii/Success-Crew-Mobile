/// File: lib/features/visitor_tracker/domain/usecases/create_visit.dart
/// Generated Documentation for create_visit.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/visit_request.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

/// Class representing `CreateVisitUseCase`.
/// Auto-generated class documentation.
class CreateVisitUseCase {
  final VisitRepository _repo;
  const CreateVisitUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Visit>> call(VisitRequest request) {
    return _repo.createVisit(request);
  }
}
