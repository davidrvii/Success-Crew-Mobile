/// File: lib/features/profile/domain/usecases/get_user_basic.dart
/// Generated Documentation for get_user_basic.dart

import '../../../../core/network/api_response.dart';
import '../entities/user_basic.dart';
import '../repositories/profile_repository.dart';

/// Class representing `GetUserBasicUseCase`.
/// Auto-generated class documentation.
class GetUserBasicUseCase {
  final ProfileRepository _repo;
  const GetUserBasicUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<UserBasic>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<UserBasic>> call() => _repo.getUserBasic();
}
