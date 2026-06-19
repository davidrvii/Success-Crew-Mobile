/// File: lib/features/out_of_office/domain/usecases/update_out_of_office.dart
/// Generated Documentation for update_out_of_office.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/out_of_office_request.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `UpdateOutOfOfficeUseCase`.
/// Auto-generated class documentation.
class UpdateOutOfOfficeUseCase {
  final OutOfOfficeRepository _repo;
  const UpdateOutOfOfficeUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OutOfOffice>> call(int id, OutOfOfficeRequest request) {
    if (request.status != null &&
        request.description == null &&
        request.startDate == null &&
        request.endDate == null) {
      return _repo.updateOutOfOfficeStatus(id, request.status!);
    }
    return _repo.updateOutOfOffice(id, request);
  }
}
