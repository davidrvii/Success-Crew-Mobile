/// File: lib/features/overtime/domain/usecases/get_overtime_basic_all.dart
/// Generated Documentation for get_overtime_basic_all.dart

import '../../../../core/network/api_response.dart';
import '../entities/overtime_basic_list.dart';
import '../repositories/overtime_repository.dart';

/// Class representing `GetOvertimeBasicAllUseCase`.
/// Auto-generated class documentation.
class GetOvertimeBasicAllUseCase {
  final OvertimeRepository _repo;
  const GetOvertimeBasicAllUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OvertimeBasicList>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OvertimeBasicList>> call() => _repo.getOvertimeBasicAll();
}
