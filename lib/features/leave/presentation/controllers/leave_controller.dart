/// File: lib/features/leave/presentation/controllers/leave_controller.dart
/// Generated Documentation for leave_controller.dart

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/utils/date_overlap_helper.dart';
import '../../../attendance/domain/usecases/get_attendance_history.dart';
import '../../../out_of_office/domain/usecases/get_out_of_office_list.dart';

import '../../domain/entities/leave.dart';
import '../../domain/usecases/get_leave_list.dart';
import '../../domain/usecases/get_leave_detail.dart';
import '../../domain/usecases/create_leave.dart';
import '../../domain/usecases/update_leave.dart';
import '../../domain/usecases/delete_leave.dart';
import '../../data/models/leave_request.dart';
import '../../../../core/storage/user_session.dart';

/// Class representing `LeaveController`.
/// Auto-generated class documentation.
class LeaveController extends ChangeNotifier {
  final GetLeaveListUseCase _getLeaveList;
  final GetLeaveDetailUseCase _getLeaveDetail;
  final CreateLeaveUseCase _createLeave;
  final UpdateLeaveUseCase _updateLeave;
  final DeleteLeaveUseCase _deleteLeave;
  final UserSession _session;
  final GetAttendanceHistoryUseCase _getAttendanceHistoryUseCase;
  final GetOutOfOfficeListUseCase _getOutOfOfficeListUseCase;

  LeaveController({
    required GetLeaveListUseCase getLeaveList,
    required GetLeaveDetailUseCase getLeaveDetail,
    required CreateLeaveUseCase createLeave,
    required UpdateLeaveUseCase updateLeave,
    required DeleteLeaveUseCase deleteLeave,
    required UserSession userSession,
    required GetAttendanceHistoryUseCase getAttendanceHistoryUseCase,
    required GetOutOfOfficeListUseCase getOutOfOfficeListUseCase,
  }) : _getLeaveList = getLeaveList,
       _getLeaveDetail = getLeaveDetail,
       _createLeave = createLeave,
       _updateLeave = updateLeave,
       _deleteLeave = deleteLeave,
       _session = userSession,
       _getAttendanceHistoryUseCase = getAttendanceHistoryUseCase,
       _getOutOfOfficeListUseCase = getOutOfOfficeListUseCase;

  bool _loading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _loading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  List<Leave> _leaves = [];
  /// Getter for `leaves` returning `List<Leave>`.
  List<Leave> get leaves => _leaves;

  Leave? _selectedLeave;
  /// Getter for `selectedLeave` returning `Leave?`.
  Leave? get selectedLeave => _selectedLeave;

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
    await fetchLeaves();
  }

  /// Method `fetchLeaves` returning `Future<void>`.
  /// Handles logic operations related to `fetchLeaves`.
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

  /// Method `fetchLeaveDetail` returning `Future<void>`.
  /// Handles logic operations related to `fetchLeaveDetail`.
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

  /// Method `submitLeave` returning `Future<bool>`.
  /// Handles logic operations related to `submitLeave`.
  Future<bool> submitLeave({
    required String type,
    required String startDate,
    required String endDate,
    required String reason,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    final start = DateTime.parse(startDate);
    final end = DateTime.parse(endDate);

    // 1. Check Attendance overlaps
    final attRes = await _getAttendanceHistoryUseCase();
    if (attRes.isSuccess && attRes.data != null) {
      for (final a in attRes.data!.history) {
        if (a.attendanceDate != null) {
          if (DateOverlapHelper.isDateInRange(a.attendanceDate!, start, end)) {
            _errorMessage = 'Terdapat absensi pada tanggal tersebut';
            _setLoading(false);
            notifyListeners();
            return false;
          }
        }
      }
    }

    // 2. Check Leave overlaps
    for (final l in _leaves) {
      final status = (l.status ?? '').toLowerCase().trim();
      if (status == 'rejected' || status == 'ditolak') continue;
      if (l.startDate != null && l.endDate != null) {
        if (DateOverlapHelper.areRangesOverlapping(start, end, l.startDate!, l.endDate!)) {
          _errorMessage = 'Terdapat cuti pada tanggal tersebut';
          _setLoading(false);
          notifyListeners();
          return false;
        }
      }
    }

    // 3. Check Out of Office overlaps
    final oooRes = await _getOutOfOfficeListUseCase();
    if (oooRes.isSuccess && oooRes.data != null) {
      for (final o in oooRes.data!) {
        final status = (o.status ?? '').toLowerCase().trim();
        if (status == 'rejected' || status == 'ditolak') continue;
        if (o.startDate != null && o.endDate != null) {
          if (DateOverlapHelper.areRangesOverlapping(start, end, o.startDate!, o.endDate!)) {
            _errorMessage = 'Terdapat dinas pada tanggal tersebut';
            _setLoading(false);
            notifyListeners();
            return false;
          }
        }
      }
    }

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

  /// Method `updateStatus` returning `Future<bool>`.
  /// Handles logic operations related to `updateStatus`.
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

  /// Method `deleteLeave` returning `Future<bool>`.
  /// Handles logic operations related to `deleteLeave`.
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

  /// Method `_setLoading` returning `void`.
  /// Handles logic operations related to `_setLoading`.
  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
