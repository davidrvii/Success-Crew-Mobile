import '../../../../core/network/api_response.dart';
import '../entities/user_detail.dart';
import '../repositories/profile_repository.dart';

class GetUserDetailUseCase {
  final ProfileRepository _repo;
  const GetUserDetailUseCase(this._repo);

  Future<ApiResponse<UserDetail>> call() => _repo.getUserDetail();
}
