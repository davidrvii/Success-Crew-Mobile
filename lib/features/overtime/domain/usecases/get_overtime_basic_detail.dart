/// File: lib/features/overtime/domain/usecases/get_overtime_basic_detail.dart
/// Generated Documentation for get_overtime_basic_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/overtime_basic.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `GetOvertimeBasicDetailUseCase`.
/// Auto-generated class documentation.
class GetOvertimeBasicDetailUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeBasicDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OvertimeBasic>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OvertimeBasic>> call(int id) => _repo.getOvertimeBasicDetail(id);
}
