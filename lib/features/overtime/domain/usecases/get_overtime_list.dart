/// File: lib/features/overtime/domain/usecases/get_overtime_list.dart
/// Generated Documentation for get_overtime_list.dart

import '../../../../core/network/api_response.dart';
import '../entities/overtime.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `GetOvertimeListUseCase`.
/// Auto-generated class documentation.
class GetOvertimeListUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeListUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<Overtime>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<Overtime>>> call() => _repo.getOvertimeList();
}
