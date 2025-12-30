import '../../../../core/network/api_response.dart';
import '../entities/registered_user.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _repo;
  const RegisterUseCase(this._repo);

  Future<ApiResponse<RegisteredUser>> call({
    required int officeId,
    required int roleId,
    required String userName,
    required String userEmail,
    required String userPassword,
  }) {
    return _repo.register(
      officeId: officeId,
      roleId: roleId,
      userName: userName,
      userEmail: userEmail,
      userPassword: userPassword,
    );
  }
}
