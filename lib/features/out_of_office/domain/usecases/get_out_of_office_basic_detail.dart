import '../../../../core/network/api_response.dart';
import '../entities/out_of_office_basic.dart';
import '../repositories/out_of_office_repository.dart';

class GetOutOfOfficeBasicDetailUseCase {
  final OutOfOfficeRepository _repo;
  const GetOutOfOfficeBasicDetailUseCase(this._repo);

  Future<ApiResponse<OutOfOfficeBasic>> call(int id) => _repo.getOutOfOfficeBasicDetail(id);
}
