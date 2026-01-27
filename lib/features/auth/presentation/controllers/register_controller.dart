import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../domain/entities/registered_user.dart';
import '../../domain/usecases/register_usecase.dart';

class RegisterController extends ChangeNotifier {
  final RegisterUseCase _registerUseCase;

  RegisterController({required RegisterUseCase registerUseCase})
    : _registerUseCase = registerUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  RegisteredUser? _registered;
  RegisteredUser? get registered => _registered;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void toggleObscure() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required int? officeId,
    required int? roleId,
  }) async {
    final n = name.trim();
    final e = email.trim();
    final p = password;

    if (n.isEmpty || e.isEmpty || p.isEmpty) {
      _errorMessage = 'Semua field wajib diisi.';
      notifyListeners();
      return false;
    }
    if (officeId == null) {
      _errorMessage = 'Pilih office.';
      notifyListeners();
      return false;
    }
    if (roleId == null) {
      _errorMessage = 'Pilih role.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    final ApiResponse<RegisteredUser> res = await _registerUseCase(
      officeId: officeId,
      roleId: roleId,
      userName: n,
      userEmail: e,
      userPassword: p,
    );

    if (res.isSuccess) {
      _registered = res.data;
      _errorMessage = null;
      _setLoading(false);
      return true;
    }

    _registered = null;
    _errorMessage = res.error?.message ?? 'Registrasi gagal.';
    _setLoading(false);
    return false;
  }

  void _setLoading(bool v) {
    if (_isLoading == v) return;
    _isLoading = v;
    notifyListeners();
  }
}
