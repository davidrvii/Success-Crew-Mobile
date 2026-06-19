/// File: lib/features/profile/presentation/controllers/profile_controller.dart
/// Generated Documentation for profile_controller.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/storage/user_session.dart';
import '../../../auth/domain/usecases/logout_usecase.dart';

import '../../domain/entities/user_basic.dart';
import '../../domain/entities/user_detail.dart';
import '../../domain/usecases/get_user_basic.dart';
import '../../domain/usecases/get_user_detail.dart';
import '../../domain/usecases/update_profile.dart';
import '../../data/models/update_profile_request.dart';

/// Class representing `ProfileController`.
/// Auto-generated class documentation.
class ProfileController extends ChangeNotifier {
  final GetUserBasicUseCase _getUserBasic;
  final GetUserDetailUseCase _getUserDetail;
  final UpdateProfileUseCase _updateProfile;
  final UserSession _session;
  final LogoutUseCase _logout;

  ProfileController({
    required GetUserBasicUseCase getUserBasic,
    required GetUserDetailUseCase getUserDetail,
    required UpdateProfileUseCase updateProfile,
    required UserSession session,
    required LogoutUseCase logout,
  }) : _getUserBasic = getUserBasic,
       _getUserDetail = getUserDetail,
       _updateProfile = updateProfile,
       _session = session,
       _logout = logout;

  // ===== state =====
  bool _loading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _loading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  UserBasic? _basic;
  /// Getter for `basic` returning `UserBasic?`.
  UserBasic? get basic => _basic;

  UserDetail? _detail;
  /// Getter for `detail` returning `UserDetail?`.
  UserDetail? get detail => _detail;

  // ===== UI fields =====
  String? employeeId;
  String? phone;
  String? birthDateText;
  String? startWorkDateText;
  String? endWorkDateText;

  String? position;
  String? employmentStatusText;

  // ===== edit form =====
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  DateTime? birthDate;

  File? _selectedPhoto;
  /// Getter for `selectedPhoto` returning `File?`.
  File? get selectedPhoto => _selectedPhoto;

  bool _editing = false;
  /// Getter for `isEditing` returning `bool`.
  bool get isEditing => _editing;

  // ===== computed for UI =====
  /// Method `_toTitleCase` returning `String`.
  /// Handles logic operations related to `_toTitleCase`.
  String _toTitleCase(String? s) {
    if (s == null || s.trim().isEmpty) return '-';
    return s.trim().split(' ').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }

  /// Getter for `displayName` returning `String`.
  String get displayName => detail?.userName ?? basic?.userName ?? '-';
  /// Getter for `displayRole` returning `String`.
  String get displayRole => _toTitleCase(detail?.roleName ?? basic?.roleName);
  /// Getter for `displayEmail` returning `String`.
  String get displayEmail => detail?.userEmail ?? '-';
  /// Getter for `displayOffice` returning `String`.
  String get displayOffice => detail?.officeName ?? '-';

  // Personal
  /// Getter for `displayEmployeeId` returning `String`.
  String get displayEmployeeId => _dashIfEmpty(employeeId);
  /// Getter for `displayPhone` returning `String`.
  String get displayPhone => _dashIfEmpty(phone);
  /// Getter for `displayBirthDate` returning `String`.
  String get displayBirthDate => _dashIfEmpty(birthDateText);
  /// Getter for `displayStartWorkDate` returning `String`.
  String get displayStartWorkDate => _dashIfEmpty(startWorkDateText);
  /// Getter for `displayEndWorkDate` returning `String`.
  String get displayEndWorkDate => _dashIfEmpty(endWorkDateText);

  // Job Info
  /// Getter for `displayPosition` returning `String`.
  String get displayPosition => _toTitleCase(position);
  /// Getter for `displayLocation` returning `String`.
  String get displayLocation => _dashIfEmpty(detail?.officeName);

  /// Getter for `displayEmploymentStatus` returning `String`.
  String get displayEmploymentStatus =>
      _dashIfEmpty(employmentStatusText);

  /// Method `setEditing` returning `void`.
  /// Handles logic operations related to `setEditing`.
  void setEditing(bool v) {
    _editing = v;
    if (!_editing) {
      _fillFormFromDetail();
      _selectedPhoto = null;
    }
    notifyListeners();
  }

  /// Method `setSelectedPhoto` returning `void`.
  /// Handles logic operations related to `setSelectedPhoto`.
  void setSelectedPhoto(File? file) {
    _selectedPhoto = file;
    notifyListeners();
  }

  /// Method `init` returning `Future<void>`.
  /// Handles logic operations related to `init`.
  Future<void> init({bool loadBasicAlso = true}) async {
    _errorMessage = null;

    await _run(() async {
      _fillDefaultUiFields();

      await _fillFromSession();

      if (loadBasicAlso) {
        final b = await _getUserBasic();
        if (b.isSuccess) _basic = b.data;
      }

      final d = await _getUserDetail();
      if (!d.isSuccess) {
        _errorMessage = _extractError(d.error);
        return;
      }

      _detail = d.data;
      _fillFormFromDetail();

      _fillUiFieldsFromDetail();
    });
  }

  /// Method `refresh` returning `Future<void>`.
  /// Handles logic operations related to `refresh`.
  Future<void> refresh() => init(loadBasicAlso: true);

  /// Method `submitUpdate` returning `Future<bool>`.
  /// Handles logic operations related to `submitUpdate`.
  Future<bool> submitUpdate() async {
    final current = _detail;
    if (current == null) {
      _errorMessage = 'Data profile belum tersedia.';
      notifyListeners();
      return false;
    }

    final newName = nameController.text.trim();
    final newEmail = emailController.text.trim();
    final newPass = passwordController.text;
    final newPhone = phoneController.text.trim();
    final newBirth = birthDate != null ? DateFormat('yyyy-MM-dd').format(birthDate!) : null;

    final request = UpdateProfileRequest(
      userName: (newName.isNotEmpty && newName != current.userName)
          ? newName
          : null,
      userEmail: (newEmail.isNotEmpty && newEmail != current.userEmail)
          ? newEmail
          : null,
      userPassword: (newPass.isNotEmpty) ? newPass : null,
      userPhone: (newPhone != current.userPhone) ? newPhone : null,
      userBirth: (newBirth != null && (current.userBirth == null || DateFormat('yyyy-MM-dd').format(current.userBirth!) != newBirth))
          ? newBirth
          : null,
      photoFile: _selectedPhoto,
    );

    final nothingChanged =
        request.toJson().isEmpty && request.photoFile == null;
    if (nothingChanged) {
      _errorMessage = 'Tidak ada perubahan untuk disimpan.';
      notifyListeners();
      return false;
    }

    bool ok = false;
    _errorMessage = null;

    await _run(() async {
      final res = await _updateProfile(request);
      if (!res.isSuccess) {
        _errorMessage = _extractError(res.error);
        ok = false;
        return;
      }

      _detail = res.data;
      _fillFormFromDetail();
      _fillUiFieldsFromDetail();

      _selectedPhoto = null;
      _editing = false;
      ok = true;
    });

    return ok;
  }

  /// Method `logout` returning `Future<void>`.
  /// Handles logic operations related to `logout`.
  Future<void> logout() async {
    await _logout();
  }

  /// Method `disposeControllers` returning `void`.
  /// Handles logic operations related to `disposeControllers`.
  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

  // ===== internal helpers =====
  /// Method `_fillDefaultUiFields` returning `void`.
  /// Handles logic operations related to `_fillDefaultUiFields`.
  void _fillDefaultUiFields() {
    phone ??= '-';
    birthDateText ??= '-';
    startWorkDateText ??= '-';
    endWorkDateText ??= '-';
  }

  /// Method `_fillFromSession` returning `Future<void>`.
  /// Handles logic operations related to `_fillFromSession`.
  Future<void> _fillFromSession() async {
    final s = await _session.readSession();
    if (s == null) return;

    employeeId ??= (s['user_id'])?.toString();

    position ??= (s['role_name'])?.toString();
  }

  /// Method `_fillUiFieldsFromDetail` returning `void`.
  /// Handles logic operations related to `_fillUiFieldsFromDetail`.
  void _fillUiFieldsFromDetail() {
    final d = _detail;
    if (d == null) return;

    position = d.roleName ?? position;
    employeeId = d.userId.toString();
    phone = d.userPhone ?? phone;
    birthDateText = d.userBirth != null ? DateFormat('dd MMM yyyy').format(d.userBirth!) : birthDateText;
    startWorkDateText = d.startWork != null ? DateFormat('dd MMM yyyy').format(d.startWork!) : startWorkDateText;
    endWorkDateText = d.endWork != null ? DateFormat('dd MMM yyyy').format(d.endWork!) : '-';
    employmentStatusText = d.contractStatus != null ? '${d.contractStatus} - ${d.crewStatus ?? "-"}' : null;
  }

  /// Method `_fillFormFromDetail` returning `void`.
  /// Handles logic operations related to `_fillFormFromDetail`.
  void _fillFormFromDetail() {
    final d = _detail;
    if (d == null) return;
    nameController.text = d.userName;
    emailController.text = d.userEmail;
    passwordController.text = '';
    phoneController.text = d.userPhone ?? '';
    birthDate = d.userBirth;
  }

  /// Method `_run` returning `Future<void>`.
  /// Handles logic operations related to `_run`.
  Future<void> _run(Future<void> Function() job) async {
    _loading = true;
    notifyListeners();
    try {
      await job();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// Method `_extractError` returning `String`.
  /// Handles logic operations related to `_extractError`.
  String _extractError(dynamic err) {
    try {
      final m = (err?.message as String?);
      if (m != null && m.trim().isNotEmpty) return m.trim();
    } catch (_) {}
    return 'Terjadi kesalahan. Silakan coba lagi.';
  }

  /// Method `_dashIfEmpty` returning `String`.
  /// Handles logic operations related to `_dashIfEmpty`.
  String _dashIfEmpty(String? v) {
    final s = (v ?? '').trim();
    return s.isEmpty ? '-' : s;
  }
}
