/// File: lib/features/profile/domain/usecases/get_user_detail.dart
/// Generated Documentation for get_user_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/user_detail.dart';
import '../repositories/profile_repository.dart';

/// Class representing `GetUserDetailUseCase`.
/// Auto-generated class documentation.
class GetUserDetailUseCase {
  final ProfileRepository _repo;
  const GetUserDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UserDetail>> call() => _repo.getUserDetail();
}
