/// File: lib/features/overtime/domain/usecases/create_overtime.dart
/// Generated Documentation for create_overtime.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/overtime_request.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `CreateOvertimeUseCase`.
/// Auto-generated class documentation.
class CreateOvertimeUseCase {
  final OvertimeRepository _repo;
  const CreateOvertimeUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Overtime>> call(OvertimeRequest request) =>
      _repo.createOvertime(request);
}
