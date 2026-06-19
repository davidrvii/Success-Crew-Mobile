/// File: lib/features/visitor_tracker/domain/usecases/get_visit_detail.dart
/// Generated Documentation for get_visit_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

/// Class representing `GetVisitDetailUseCase`.
/// Auto-generated class documentation.
class GetVisitDetailUseCase {
  final VisitRepository _repo;
  const GetVisitDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Visit>> call(int visitId) {
    return _repo.getVisitDetail(visitId);
  }
}
