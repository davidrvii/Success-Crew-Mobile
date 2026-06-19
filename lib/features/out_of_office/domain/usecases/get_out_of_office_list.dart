/// File: lib/features/out_of_office/domain/usecases/get_out_of_office_list.dart
/// Generated Documentation for get_out_of_office_list.dart

import '../../../../core/network/api_response.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `GetOutOfOfficeListUseCase`.
/// Auto-generated class documentation.
class GetOutOfOfficeListUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeListUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<OutOfOffice>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<OutOfOffice>>> call() => _repo.getOutOfOfficeList();
}
