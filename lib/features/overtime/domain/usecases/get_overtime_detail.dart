/// File: lib/features/overtime/domain/usecases/get_overtime_detail.dart
/// Generated Documentation for get_overtime_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `GetOvertimeDetailUseCase`.
/// Auto-generated class documentation.
class GetOvertimeDetailUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Overtime>> call(int id) => _repo.getOvertimeDetail(id);
}
