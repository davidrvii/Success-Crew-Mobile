import '../../../../core/network/api_response.dart';
import '../../data/models/out_of_office_request.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

class UpdateOutOfOfficeUseCase {
  final OutOfOfficeRepository _repo;
  const UpdateOutOfOfficeUseCase(this._repo);

  Future<ApiResponse<OutOfOffice>> call(int id, OutOfOfficeRequest request) {
    if (request.status != null &&
        request.description == null &&
        request.date == null) {
      return _repo.updateOutOfOfficeStatus(id, request.status!);
    }
    return _repo.updateOutOfOffice(id, request);
  }
}
