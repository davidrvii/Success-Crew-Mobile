import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../repositories/crew_repository.dart';

class GetCrewDetailUseCase {
  final CrewRepository _repository;
  GetCrewDetailUseCase(this._repository);

  Future<ApiResponse<UserDetail>> call(int userId) {
    return _repository.getCrewDetail(userId);
  }
}
