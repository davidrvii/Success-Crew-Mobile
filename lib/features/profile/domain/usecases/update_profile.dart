import '../../../../core/network/api_response.dart';
import '../../data/models/update_profile_request.dart';
import '../entities/user_detail.dart';
import '../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _repo;
  const UpdateProfileUseCase(this._repo);

  Future<ApiResponse<UserDetail>> call(UpdateProfileRequest request) =>
      _repo.updateProfile(request);
}
