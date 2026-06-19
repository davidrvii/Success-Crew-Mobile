/// File: lib/features/leave/domain/usecases/get_leave_list.dart
/// Generated Documentation for get_leave_list.dart

import '../../../../core/network/api_response.dart';
import '../entities/leave.dart';
import '../repositories/leave_repository.dart';

/// Class representing `GetLeaveListUseCase`.
/// Auto-generated class documentation.
class GetLeaveListUseCase {
  final LeaveRepository _repo;
  const GetLeaveListUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<Leave>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<Leave>>> call() => _repo.getLeaveList();
}
