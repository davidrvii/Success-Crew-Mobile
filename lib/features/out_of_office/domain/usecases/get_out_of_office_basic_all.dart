/// File: lib/features/out_of_office/domain/usecases/get_out_of_office_basic_all.dart
/// Generated Documentation for get_out_of_office_basic_all.dart

import '../../../../core/network/api_response.dart';
import '../entities/out_of_office_basic_list.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `GetOutOfOfficeBasicAllUseCase`.
/// Auto-generated class documentation.
class GetOutOfOfficeBasicAllUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeBasicAllUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OutOfOfficeBasicList>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OutOfOfficeBasicList>> call() => _repo.getOutOfOfficeBasicAll();
}
