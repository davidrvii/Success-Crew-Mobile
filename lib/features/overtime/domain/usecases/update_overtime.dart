/// File: lib/features/overtime/domain/usecases/update_overtime.dart
/// Generated Documentation for update_overtime.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/overtime_request.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `UpdateOvertimeUseCase`.
/// Auto-generated class documentation.
class UpdateOvertimeUseCase {
  final OvertimeRepository _repo;
  const UpdateOvertimeUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Overtime>> call(int id, OvertimeRequest request) {
    if (request.status != null &&
        request.reason == null &&
        request.startTime == null &&
        request.endTime == null &&
        request.overtimeDate == null) {
      return _repo.updateOvertimeStatus(id, request.status!);
    }
    return _repo.updateOvertime(id, request);
  }
}
