/// File: lib/features/out_of_office/domain/usecases/delete_out_of_office.dart
/// Generated Documentation for delete_out_of_office.dart

import '../../../../core/network/api_response.dart';
import '../repositories/out_of_office_repository.dart';

/// Class representing `DeleteOutOfOfficeUseCase`.
/// Auto-generated class documentation.
class DeleteOutOfOfficeUseCase {
  final OutOfOfficeRepository _repo;
  const DeleteOutOfOfficeUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int id) => _repo.deleteOutOfOffice(id);
}
