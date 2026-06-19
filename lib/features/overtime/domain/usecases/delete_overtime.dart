/// File: lib/features/overtime/domain/usecases/delete_overtime.dart
/// Generated Documentation for delete_overtime.dart

import '../../../../core/network/api_response.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `DeleteOvertimeUseCase`.
/// Auto-generated class documentation.
class DeleteOvertimeUseCase {
  final OvertimeRepository _repo;
  const DeleteOvertimeUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int id) => _repo.deleteOvertime(id);
}
