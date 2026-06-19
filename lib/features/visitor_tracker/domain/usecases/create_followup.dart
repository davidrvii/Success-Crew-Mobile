/// File: lib/features/visitor_tracker/domain/usecases/create_followup.dart
/// Generated Documentation for create_followup.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Class representing `CreateFollowUpUseCase`.
/// Auto-generated class documentation.
class CreateFollowUpUseCase {
  final VisitRepository _repo;
  const CreateFollowUpUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<FollowUp>> call(int visitId, FollowUpRequest request) {
    return _repo.createFollowUp(visitId, request);
  }
}
