import '../../../../core/network/api_response.dart';
import '../repositories/out_of_office_repository.dart';

class DeleteOutOfOfficeUseCase {
  final OutOfOfficeRepository _repo;
  const DeleteOutOfOfficeUseCase(this._repo);

  Future<ApiResponse<int>> call(int id) => _repo.deleteOutOfOffice(id);
}
