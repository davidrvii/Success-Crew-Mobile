import '../../../../core/network/api_response.dart';
import '../entities/out_of_office.dart';
import '../repositories/out_of_office_repository.dart';

class GetOutOfOfficeListUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeListUseCase(this._repo);

  Future<ApiResponse<List<OutOfOffice>>> call() => _repo.getOutOfOfficeList();
}
