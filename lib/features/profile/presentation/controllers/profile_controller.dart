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
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  UserBasic? _basic;
  UserBasic? get basic => _basic;

  UserDetail? _detail;
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
  File? get selectedPhoto => _selectedPhoto;

  bool _editing = false;
  bool get isEditing => _editing;

  // ===== computed for UI =====
  String _toTitleCase(String? s) {
    if (s == null || s.trim().isEmpty) return '-';
    return s.trim().split(' ').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }

  String get displayName => detail?.userName ?? basic?.userName ?? '-';
  String get displayRole => _toTitleCase(detail?.roleName ?? basic?.roleName);
  String get displayEmail => detail?.userEmail ?? '-';
  String get displayOffice => detail?.officeName ?? '-';

  // Personal
  String get displayEmployeeId => _dashIfEmpty(employeeId);
  String get displayPhone => _dashIfEmpty(phone);
  String get displayBirthDate => _dashIfEmpty(birthDateText);
  String get displayStartWorkDate => _dashIfEmpty(startWorkDateText);
  String get displayEndWorkDate => _dashIfEmpty(endWorkDateText);

  // Job Info
  String get displayPosition => _toTitleCase(position);
  String get displayLocation => _dashIfEmpty(detail?.officeName);

  String get displayEmploymentStatus =>
      _dashIfEmpty(employmentStatusText);

  void setEditing(bool v) {
    _editing = v;
    if (!_editing) {
      _fillFormFromDetail();
      _selectedPhoto = null;
    }
    notifyListeners();
  }

  void setSelectedPhoto(File? file) {
    _selectedPhoto = file;
    notifyListeners();
  }

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

  Future<void> refresh() => init(loadBasicAlso: true);

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

  Future<void> logout() async {
    await _logout();
  }

  void disposeControllers() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
  }

  // ===== internal helpers =====
  void _fillDefaultUiFields() {
    phone ??= '-';
    birthDateText ??= '-';
    startWorkDateText ??= '-';
    endWorkDateText ??= '-';
  }

  Future<void> _fillFromSession() async {
    final s = await _session.readSession();
    if (s == null) return;

    employeeId ??= (s['user_id'])?.toString();

    position ??= (s['role_name'])?.toString();
  }

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

  void _fillFormFromDetail() {
    final d = _detail;
    if (d == null) return;
    nameController.text = d.userName;
    emailController.text = d.userEmail;
    passwordController.text = '';
    phoneController.text = d.userPhone ?? '';
    birthDate = d.userBirth;
  }

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

  String _extractError(dynamic err) {
    try {
      final m = (err?.message as String?);
      if (m != null && m.trim().isNotEmpty) return m.trim();
    } catch (_) {}
    return 'Terjadi kesalahan. Silakan coba lagi.';
  }

  String _dashIfEmpty(String? v) {
    final s = (v ?? '').trim();
    return s.isEmpty ? '-' : s;
  }
}
