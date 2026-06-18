import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/leave.dart';
import '../../domain/usecases/get_leave_list.dart';
import '../../domain/usecases/get_leave_detail.dart';
import '../../domain/usecases/create_leave.dart';
import '../../domain/usecases/update_leave.dart';
import '../../domain/usecases/delete_leave.dart';
import '../../data/models/leave_request.dart';
import '../../../../core/storage/user_session.dart';

class LeaveController extends ChangeNotifier {
  final GetLeaveListUseCase _getLeaveList;
  final GetLeaveDetailUseCase _getLeaveDetail;
  final CreateLeaveUseCase _createLeave;
  final UpdateLeaveUseCase _updateLeave;
  final DeleteLeaveUseCase _deleteLeave;
  final UserSession _session;

  LeaveController({
    required GetLeaveListUseCase getLeaveList,
    required GetLeaveDetailUseCase getLeaveDetail,
    required CreateLeaveUseCase createLeave,
    required UpdateLeaveUseCase updateLeave,
    required DeleteLeaveUseCase deleteLeave,
    required UserSession userSession,
  }) : _getLeaveList = getLeaveList,
       _getLeaveDetail = getLeaveDetail,
       _createLeave = createLeave,
       _updateLeave = updateLeave,
       _deleteLeave = deleteLeave,
       _session = userSession;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<Leave> _leaves = [];
  List<Leave> get leaves => _leaves;

  Leave? _selectedLeave;
  Leave? get selectedLeave => _selectedLeave;

  bool _isOwner = false;
  bool get isOwner => _isOwner;

  Future<void> init() async {
    final session = await _session.readSession();
    final role = (session?['role_name'] as String?)?.trim().toLowerCase();
    _isOwner = role == 'owner';
    notifyListeners();
    await fetchLeaves();
  }

  Future<void> fetchLeaves() async {
    _setLoading(true);
    _errorMessage = null;

    // The repository handles the user ID internally
    final res = await _getLeaveList();

    if (res.isSuccess) {
      _leaves = res.data ?? [];
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memuat data cuti';
    }

    _setLoading(false);
  }

  Future<void> fetchLeaveDetail(int id) async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _getLeaveDetail(id);

    if (res.isSuccess) {
      _selectedLeave = res.data;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memuat detail cuti';
    }

    _setLoading(false);
  }

  Future<bool> submitLeave({
    required String type,
    required String startDate,
    required String endDate,
    required String reason,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    final req = LeaveRequest(
      leaveType: type,
      startDate: startDate,
      endDate: endDate,
      reason: reason,
      status: 'pending',
    );

    final res = await _createLeave(req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchLeaves(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal mengajukan cuti';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStatus(int id, String status) async {
    _setLoading(true);
    _errorMessage = null;

    final req = LeaveRequest(status: status);
    final res = await _updateLeave(id, req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchLeaves(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memperbarui status cuti';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteLeave(int id) async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _deleteLeave(id);

    _setLoading(false);

    if (res.isSuccess) {
      fetchLeaves(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal menghapus cuti';
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
