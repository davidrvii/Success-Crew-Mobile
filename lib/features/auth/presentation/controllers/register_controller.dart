/// File: lib/features/auth/presentation/controllers/register_controller.dart
/// Generated Documentation for register_controller.dart

import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../domain/entities/registered_user.dart';
import '../../domain/usecases/register_usecase.dart';

/// Class representing `RegisterController`.
/// Auto-generated class documentation.
class RegisterController extends ChangeNotifier {
  final RegisterUseCase _registerUseCase;

  RegisterController({required RegisterUseCase registerUseCase})
    : _registerUseCase = registerUseCase;

  bool _isLoading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _isLoading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  RegisteredUser? _registered;
  /// Getter for `registered` returning `RegisteredUser?`.
  RegisteredUser? get registered => _registered;

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

  /// Method `register` returning `Future<bool>`.
  /// Handles logic operations related to `register`.
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

  /// Method `_setLoading` returning `void`.
  /// Handles logic operations related to `_setLoading`.
  void _setLoading(bool v) {
    if (_isLoading == v) return;
    _isLoading = v;
    notifyListeners();
  }
}
