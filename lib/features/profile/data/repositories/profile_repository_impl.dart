import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/user_basic.dart';
import '../../domain/entities/user_detail.dart';
import '../../domain/repositories/profile_repository.dart';

import '../datasources/profile_remote_datasource.dart';
import '../models/update_profile_request.dart';
import '../models/user_basic_model.dart';
import '../models/user_detail_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remote;
  final UserSession _session;

  ProfileRepositoryImpl(this._remote, this._session);

  @override
  Future<ApiResponse<UserBasic>> getUserBasic() async {
    final userId = await _requireUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }

    final res = await _remote.getUserBasic(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.userBasic;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (userBasic is null).',
        ),
      );
    }

    return ApiResponse.success(_mapBasic(dto));
  }

  @override
  Future<ApiResponse<UserDetail>> getUserDetail() async {
    final userId = await _requireUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }

    final res = await _remote.getUserDetail(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.userDetail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (userDetail is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDetail(dto));
  }

  @override
  Future<ApiResponse<UserDetail>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    final userId = await _requireUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }

    final res = await _remote.updateProfile(userId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.userDetail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (updated user is null).',
        ),
      );
    }

    await _syncSessionAfterUpdate(dto);

    return ApiResponse.success(_mapDetail(dto));
  }

  // ========= helpers =========

  Future<String?> _requireUserId() async {
    final session = await _session.readSession();
    final userId = session?['user_id']?.toString();
    if (userId == null || userId.isEmpty) return null;
    return userId;
  }

  UserBasic _mapBasic(UserBasicDto dto) {
    return UserBasic(
      userId: dto.userId,
      userName: dto.userName,
      userPhoto: dto.userPhoto,
      roleName: dto.roleName,
    );
  }

  UserDetail _mapDetail(UserDetailDto dto) {
    return UserDetail(
      userId: dto.userId,
      officeId: dto.officeId,
      roleId: dto.roleId,
      userName: dto.userName,
      userEmail: dto.userEmail,
      userPhoto: dto.userPhoto,
      roleName: dto.roleName,
      officeName: dto.officeName,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }

  Future<void> _syncSessionAfterUpdate(UserDetailDto dto) async {
    final raw = await _session.readSession();
    if (raw == null) return;

    raw['user_name'] = dto.userName;
    raw['user_email'] = dto.userEmail;
    raw['role_id'] = dto.roleId;
    raw['role_name'] = dto.roleName;
    raw['office_id'] = dto.officeId;
    raw['office_name'] = dto.officeName;
  }
}
