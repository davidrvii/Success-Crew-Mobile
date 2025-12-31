import '../../../../core/network/api_response.dart';
import '../../data/models/update_profile_request.dart';
import '../entities/user_basic.dart';
import '../entities/user_detail.dart';

abstract class ProfileRepository {
  Future<ApiResponse<UserBasic>> getUserBasic();
  Future<ApiResponse<UserDetail>> getUserDetail();
  Future<ApiResponse<UserDetail>> updateProfile(UpdateProfileRequest request);
}
