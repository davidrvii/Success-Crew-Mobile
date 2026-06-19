/// File: lib/features/leave/domain/usecases/create_leave.dart
/// Generated Documentation for create_leave.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/leave_request.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

/// Class representing `CreateLeaveUseCase`.
/// Auto-generated class documentation.
class CreateLeaveUseCase {
  final LeaveRepository _repo;
  const CreateLeaveUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Leave>> call(LeaveRequest request) =>
      _repo.createLeave(request);
}
