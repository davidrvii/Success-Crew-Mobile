/// File: lib/features/out_of_office/domain/usecases/create_out_of_office.dart
/// Generated Documentation for create_out_of_office.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/out_of_office_request.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `CreateOutOfOfficeUseCase`.
/// Auto-generated class documentation.
class CreateOutOfOfficeUseCase {
  final OutOfOfficeRepository _repo;
  const CreateOutOfOfficeUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OutOfOffice>> call(OutOfOfficeRequest request) =>
      _repo.createOutOfOffice(request);
}
