import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../../auth/domain/entities/auth_session.dart';

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
    final userIdRes = await _requireUserId();
    if (!userIdRes.isSuccess) return ApiResponse.failure(userIdRes.error!);

    final int userId = userIdRes.data!;

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
    final userIdRes = await _requireUserId();
    if (!userIdRes.isSuccess) return ApiResponse.failure(userIdRes.error!);

    final int userId = userIdRes.data!;

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
    final userIdRes = await _requireUserId();
    if (!userIdRes.isSuccess) return ApiResponse.failure(userIdRes.error!);

    final int userId = userIdRes.data!;

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
  Future<ApiResponse<int>> _requireUserId() async {
    final int? userId = await _session.readUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }
    return ApiResponse.success(userId);
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
      crewStatus: dto.crewStatus,
      contractStatus: dto.contractStatus,
      userPhone: dto.userPhone,
      userBirth: dto.userBirth,
      startWork: dto.startWork,
      endWork: dto.endWork,
    );
  }

  Future<void> _syncSessionAfterUpdate(UserDetailDto dto) async {
    final raw = await _session.readSession();
    if (raw == null) return;

    final int userId = (raw['user_id'] as num).toInt();

    final String roleName = (dto.roleName ?? raw['role_name'] ?? '').toString();
    final String officeName = (dto.officeName ?? raw['office_name'] ?? '')
        .toString();

    final updated = AuthSession(
      userId: userId,
      userName: dto.userName,
      userEmail: dto.userEmail,
      roleId: dto.roleId,
      roleName: roleName,
      officeId: dto.officeId,
      officeName: officeName,
      token: (raw['token'] ?? '').toString(),
    );

    await _session.saveSession(updated);
  }
}
