/// File: lib/features/out_of_office/domain/usecases/get_out_of_office_detail.dart
/// Generated Documentation for get_out_of_office_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `GetOutOfOfficeDetailUseCase`.
/// Auto-generated class documentation.
class GetOutOfOfficeDetailUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OutOfOffice>> call(int id) => _repo.getOutOfOfficeDetail(id);
}
