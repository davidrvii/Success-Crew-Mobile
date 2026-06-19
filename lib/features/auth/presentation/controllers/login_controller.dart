/// File: lib/features/auth/presentation/controllers/login_controller.dart
/// Generated Documentation for login_controller.dart

import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/usecases/login_usecase.dart';

/// Class representing `LoginController`.
/// Auto-generated class documentation.
class LoginController extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginController({required LoginUseCase loginUseCase})
    : _loginUseCase = loginUseCase;

  bool _isLoading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _isLoading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  AuthSession? _session;
  /// Getter for `session` returning `AuthSession?`.
  AuthSession? get session => _session;

  bool _obscurePassword = true;
  /// Getter for `obscurePassword` returning `bool`.
  bool get obscurePassword => _obscurePassword;

  /// Method `toggleObscure` returning `void`.
  /// Handles logic operations related to `toggleObscure`.
  void toggleObscure() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  /// Method `clearError` returning `void`.
  /// Handles logic operations related to `clearError`.
  void clearError() {
    if (_errorMessage == null) return;
    _errorMessage = null;
    notifyListeners();
  }

  /// Method `login` returning `Future<bool>`.
  /// Handles logic operations related to `login`.
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

  /// Method `_setLoading` returning `void`.
  /// Handles logic operations related to `_setLoading`.
  void _setLoading(bool v) {
    if (_isLoading == v) return;
    _isLoading = v;
    notifyListeners();
  }
}
