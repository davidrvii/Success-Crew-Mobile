import '../../../../core/network/api_response.dart';
import '../entities/user_basic.dart';
import '../repositories/profile_repository.dart';

class GetUserBasicUseCase {
  final ProfileRepository _repo;
  const GetUserBasicUseCase(this._repo);

  Future<ApiResponse<UserBasic>> call() => _repo.getUserBasic();
}
