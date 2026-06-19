/// File: lib/features/leave/domain/usecases/get_leave_detail.dart
/// Generated Documentation for get_leave_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

/// Class representing `GetLeaveDetailUseCase`.
/// Auto-generated class documentation.
class GetLeaveDetailUseCase {
  final LeaveRepository _repo;
  const GetLeaveDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Leave>> call(int id) => _repo.getLeaveDetail(id);
}
