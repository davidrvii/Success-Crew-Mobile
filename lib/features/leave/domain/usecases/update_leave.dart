/// File: lib/features/leave/domain/usecases/update_leave.dart
/// Generated Documentation for update_leave.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/leave_request.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

/// Class representing `UpdateLeaveUseCase`.
/// Auto-generated class documentation.
class UpdateLeaveUseCase {
  final LeaveRepository _repo;
  const UpdateLeaveUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Leave>> call(int id, LeaveRequest request) =>
      _repo.updateLeave(id, request);
}
