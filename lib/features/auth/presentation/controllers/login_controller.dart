import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/usecases/login_usecase.dart';

class LoginController extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginController({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  AuthSession? _session;
  AuthSession? get session => _session;

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

  Future<bool> login({required String email, required String password}) async {
    final e = email.trim();
    final p = password;

    if (e.isEmpty || p.isEmpty) {
      _errorMessage = 'Email dan password wajib diisi.';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _errorMessage = null;

    final ApiResponse<AuthSession> res = await _loginUseCase(
      email: e,
      password: p,
    );

    if (res.isSuccess) {
      _session = res.data;
      _errorMessage = null;
      _setLoading(false);
      return true;
    }

    _session = null;
    _errorMessage = res.error?.message ?? 'Login gagal.';
    _setLoading(false);
    return false;
  }

  void _setLoading(bool v) {
    if (_isLoading == v) return;
    _isLoading = v;
    notifyListeners();
  }
}
