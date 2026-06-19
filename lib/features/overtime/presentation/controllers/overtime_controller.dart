/// File: lib/features/overtime/presentation/controllers/overtime_controller.dart
/// Generated Documentation for overtime_controller.dart

import 'package:flutter/material.dart';

import '../../domain/entities/overtime.dart';
import '../../domain/usecases/get_overtime_list.dart';
import '../../domain/usecases/create_overtime.dart';
import '../../domain/usecases/update_overtime.dart';
import '../../domain/usecases/delete_overtime.dart';
import '../../data/models/overtime_request.dart';
import '../../../../core/storage/user_session.dart';

/// Class representing `OvertimeController`.
/// Auto-generated class documentation.
class OvertimeController extends ChangeNotifier {
  final GetOvertimeListUseCase _getOvertimeList;
  final CreateOvertimeUseCase _createOvertime;
  final UpdateOvertimeUseCase _updateOvertime;
  final DeleteOvertimeUseCase _deleteOvertime;
  final UserSession _session;

  OvertimeController({
    required GetOvertimeListUseCase getOvertimeList,
    required CreateOvertimeUseCase createOvertime,
    required UpdateOvertimeUseCase updateOvertime,
    required DeleteOvertimeUseCase deleteOvertime,
    required UserSession userSession,
  }) : _getOvertimeList = getOvertimeList,
       _createOvertime = createOvertime,
       _updateOvertime = updateOvertime,
       _deleteOvertime = deleteOvertime,
       _session = userSession;

  bool _loading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _loading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  List<Overtime> _overtimes = [];
  /// Getter for `overtimes` returning `List<Overtime>`.
  List<Overtime> get overtimes => _overtimes;

  bool _isOwner = false;
  /// Getter for `isOwner` returning `bool`.
  bool get isOwner => _isOwner;

  /// Method `init` returning `Future<void>`.
  /// Handles logic operations related to `init`.
  Future<void> init() async {
    final session = await _session.readSession();
    final role = (session?['role_name'] as String?)?.trim().toLowerCase();
    _isOwner = role == 'owner';
    notifyListeners();
    await fetchOvertimes();
  }

  /// Method `fetchOvertimes` returning `Future<void>`.
  /// Handles logic operations related to `fetchOvertimes`.
  Future<void> fetchOvertimes() async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _getOvertimeList(); 

    if (res.isSuccess) {
      _overtimes = res.data ?? [];
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memuat data lembur';
    }

    _setLoading(false);
  }

  /// Method `submitOvertime` returning `Future<bool>`.
  /// Handles logic operations related to `submitOvertime`.
  Future<bool> submitOvertime({
    required String date,
    required String startTime,
    required String endTime,
    required String reason,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    final req = OvertimeRequest(
      overtimeDate: date,
      startTime: startTime,
      endTime: endTime,
      reason: reason,
      status: 'pending',
    );

    final res = await _createOvertime(req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOvertimes(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal mengajukan lembur';
      notifyListeners();
      return false;
    }
  }

  /// Method `updateStatus` returning `Future<bool>`.
  /// Handles logic operations related to `updateStatus`.
  Future<bool> updateStatus(int id, String status) async {
    _setLoading(true);
    _errorMessage = null;

    final req = OvertimeRequest(status: status);
    final res = await _updateOvertime(id, req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOvertimes(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memperbarui status lembur';
      notifyListeners();
      return false;
    }
  }

  /// Method `deleteOvertime` returning `Future<bool>`.
  /// Handles logic operations related to `deleteOvertime`.
  Future<bool> deleteOvertime(int id) async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _deleteOvertime(id);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOvertimes(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal menghapus lembur';
      notifyListeners();
      return false;
    }
  }

  /// Method `_setLoading` returning `void`.
  /// Handles logic operations related to `_setLoading`.
  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
