/// File: lib/features/out_of_office/domain/usecases/update_out_of_office_status.dart
/// Generated Documentation for update_out_of_office_status.dart

import '../../../../core/network/api_response.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `UpdateOutOfOfficeStatusUseCase`.
/// Auto-generated class documentation.
class UpdateOutOfOfficeStatusUseCase {
  final OutOfOfficeRepository _repo;
  const UpdateOutOfOfficeStatusUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<OutOfOffice>> call(int id, String status) =>
      _repo.updateOutOfOfficeStatus(id, status);
}
