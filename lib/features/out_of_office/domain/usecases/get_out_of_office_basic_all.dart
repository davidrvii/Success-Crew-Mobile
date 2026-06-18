import '../../../../core/network/api_response.dart';
import '../entities/out_of_office_basic_list.dart';
import '../repositories/out_of_office_repository.dart';

class GetOutOfOfficeBasicAllUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeBasicAllUseCase(this._repo);

  Future<ApiResponse<OutOfOfficeBasicList>> call() => _repo.getOutOfOfficeBasicAll();
}
