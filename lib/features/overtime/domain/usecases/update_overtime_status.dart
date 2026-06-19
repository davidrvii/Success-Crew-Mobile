/// File: lib/features/overtime/domain/usecases/update_overtime_status.dart
/// Generated Documentation for update_overtime_status.dart

import '../../../../core/network/api_response.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `UpdateOvertimeStatusUseCase`.
/// Auto-generated class documentation.
class UpdateOvertimeStatusUseCase {
  final OvertimeRepository _repo;
  const UpdateOvertimeStatusUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Overtime>> call(int id, String status) =>
      _repo.updateOvertimeStatus(id, status);
}
