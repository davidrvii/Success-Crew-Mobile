/// File: lib/features/out_of_office/domain/usecases/get_out_of_office_basic_detail.dart
/// Generated Documentation for get_out_of_office_basic_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/out_of_office_basic.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `GetOutOfOfficeBasicDetailUseCase`.
/// Auto-generated class documentation.
class GetOutOfOfficeBasicDetailUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeBasicDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OutOfOfficeBasic>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OutOfOfficeBasic>> call(int id) => _repo.getOutOfOfficeBasicDetail(id);
}
