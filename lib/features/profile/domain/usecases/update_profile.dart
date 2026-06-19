/// File: lib/features/profile/domain/usecases/update_profile.dart
/// Generated Documentation for update_profile.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/update_profile_request.dart';
import '../entities/user_detail.dart';
import '../repositories/profile_repository.dart';

/// Class representing `UpdateProfileUseCase`.
/// Auto-generated class documentation.
class UpdateProfileUseCase {
  final ProfileRepository _repo;
  const UpdateProfileUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UserDetail>> call(UpdateProfileRequest request) =>
      _repo.updateProfile(request);
}
