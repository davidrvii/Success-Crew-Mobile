import '../../../../core/network/api_response.dart';
import '../../data/models/out_of_office_request.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

class CreateOutOfOfficeUseCase {
  final OutOfOfficeRepository _repo;
  const CreateOutOfOfficeUseCase(this._repo);

  Future<ApiResponse<OutOfOffice>> call(OutOfOfficeRequest request) =>
      _repo.createOutOfOffice(request);
}
