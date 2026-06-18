import '../../../../core/network/api_response.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

class UpdateOutOfOfficeStatusUseCase {
  final OutOfOfficeRepository _repo;
  const UpdateOutOfOfficeStatusUseCase(this._repo);

  Future<ApiResponse<OutOfOffice>> call(int id, String status) =>
      _repo.updateOutOfOfficeStatus(id, status);
}
