import '../../../../core/network/api_response.dart';
import '../entities/auth_session.dart';
import '../entities/registered_user.dart';

abstract class AuthRepository {
  Future<ApiResponse<AuthSession>> login({
    required String email,
    required String password,
  });

  Future<ApiResponse<RegisteredUser>> register({
    required int officeId,
    required int roleId,
    required String userName,
    required String userEmail,
    required String userPassword,
  });

  Future<void> logout();
}
