import 'package:flutter/material.dart';

import '../../domain/entities/overtime.dart';
import '../../domain/usecases/get_overtime_list.dart';
import '../../domain/usecases/create_overtime.dart';
import '../../domain/usecases/update_overtime.dart';
import '../../data/models/overtime_request.dart';
import '../../../../core/storage/user_session.dart';

class OvertimeController extends ChangeNotifier {
  final GetOvertimeListUseCase _getOvertimeList;
  final CreateOvertimeUseCase _createOvertime;
  final UpdateOvertimeUseCase _updateOvertime;
  final UserSession _session;

  OvertimeController({
    required GetOvertimeListUseCase getOvertimeList,
    required CreateOvertimeUseCase createOvertime,
    required UpdateOvertimeUseCase updateOvertime,
    required UserSession userSession,
  }) : _getOvertimeList = getOvertimeList,
       _createOvertime = createOvertime,
       _updateOvertime = updateOvertime,
       _session = userSession;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Overtime> _overtimes = [];
  List<Overtime> get overtimes => _overtimes;

  bool _isOwner = false;
  bool get isOwner => _isOwner;

  Future<void> init() async {
    final session = await _session.readSession();
    final role = (session?['role_name'] as String?)?.trim().toLowerCase();
    _isOwner = role == 'owner';
    notifyListeners();
    await fetchOvertimes();
  }

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

  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
