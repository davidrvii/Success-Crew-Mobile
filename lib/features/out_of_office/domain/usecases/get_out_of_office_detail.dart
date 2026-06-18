import '../../../../core/network/api_response.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

class GetOutOfOfficeDetailUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeDetailUseCase(this._repo);

  Future<ApiResponse<OutOfOffice>> call(int id) => _repo.getOutOfOfficeDetail(id);
}
