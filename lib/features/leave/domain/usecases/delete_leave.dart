/// File: lib/features/leave/domain/usecases/delete_leave.dart
/// Generated Documentation for delete_leave.dart

import '../../../../core/network/api_response.dart';
import '../repositories/leave_repository.dart';

/// Class representing `DeleteLeaveUseCase`.
/// Auto-generated class documentation.
class DeleteLeaveUseCase {
  final LeaveRepository _repo;
  const DeleteLeaveUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int id) => _repo.deleteLeave(id);
}
