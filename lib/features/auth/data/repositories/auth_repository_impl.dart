import 'package:success_crew/features/auth/domain/entities/auth_session.dart';
import 'package:success_crew/features/auth/domain/entities/registered_user.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/token_storage.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_api.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  final TokenStorage _tokenStorage;
  final UserSession _userSession;

  AuthRepositoryImpl(this._remote, this._tokenStorage, this._userSession);

  @override
  Future<ApiResponse<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    final res = await _remote.login(
      LoginRequest(email: email, password: password),
    );

    if (!res.isSuccess) {
      return ApiResponse.failure(res.error!);
    }

    final loginResult = res.data?.loginResult;
    if (loginResult == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected login response (loginResult is null).',
        ),
      );
    }

    final session = AuthSession(
      userId: loginResult.userId,
      userName: loginResult.userName,
      userEmail: loginResult.userEmail,
      roleId: loginResult.roleId,
      roleName: loginResult.roleName,
      officeId: loginResult.officeId,
      officeName: loginResult.officeName,
      token: loginResult.token,
    );

    try {
      await _tokenStorage.saveAccessToken(session.token);

      await _userSession.saveSession(session);

      return ApiResponse.success(session);
    } catch (e) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Failed to persist session data.',
        ),
      );
    }
  }

  @override
  Future<ApiResponse<RegisteredUser>> register({
    required int officeId,
    required int roleId,
    required String userName,
    required String userEmail,
    required String userPassword,
  }) async {
    final res = await _remote.register(
      RegisterRequest(
        officeId: officeId,
        roleId: roleId,
        userName: userName,
        userEmail: userEmail,
        userPassword: userPassword,
      ),
    );

    if (!res.isSuccess) {
      return ApiResponse.failure(res.error!);
    }

    final userRegistered = res.data?.userRegistered;
    if (userRegistered == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected register response (userRegistered is null).',
        ),
      );
    }

    final registeredUser = RegisteredUser(
      userId: userRegistered.userId,
      officeId: userRegistered.officeId,
      roleId: userRegistered.roleId,
      userName: userRegistered.userName,
      userEmail: userRegistered.userEmail,
    );

    return ApiResponse.success(registeredUser);
  }

  @override
  Future<void> logout() async {
    await _tokenStorage.clear();
    await _userSession.clear();
  }
}
