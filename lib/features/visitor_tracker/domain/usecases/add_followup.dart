/// File: lib/features/visitor_tracker/domain/usecases/add_followup.dart
/// Generated Documentation for add_followup.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/followup_request.dart';
import '../entities/followup.dart';
import '../repositories/visit_repository.dart';

/// Add a follow-up via POST /follow-up/add (non-nested, requires visit_id in body)
/// Class representing `AddFollowUpUseCase`.
/// Auto-generated class documentation.
class AddFollowUpUseCase {
  final VisitRepository _repo;
  const AddFollowUpUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<FollowUp>> call(FollowUpRequest request) {
    return _repo.addFollowUp(request);
  }
}
