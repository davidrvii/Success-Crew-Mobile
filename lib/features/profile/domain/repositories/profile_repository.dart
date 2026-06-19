/// File: lib/features/profile/domain/repositories/profile_repository.dart
/// Generated Documentation for profile_repository.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/update_profile_request.dart';
import '../entities/user_basic.dart';
import '../entities/user_detail.dart';

abstract class ProfileRepository {
  /// Method `getUserBasic` returning `Future<ApiResponse<UserBasic>>`.
  /// Handles logic operations related to `getUserBasic`.
  Future<ApiResponse<UserBasic>> getUserBasic();
  /// Method `getUserDetail` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `getUserDetail`.
  Future<ApiResponse<UserDetail>> getUserDetail();
  /// Method `updateProfile` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `updateProfile`.
  Future<ApiResponse<UserDetail>> updateProfile(UpdateProfileRequest request);
}
