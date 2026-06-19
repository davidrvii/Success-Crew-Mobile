import 'package:flutter/material.dart';

import '../../../../core/utils/date_overlap_helper.dart';
import '../../../attendance/domain/usecases/get_attendance_history.dart';
import '../../../leave/domain/usecases/get_leave_list.dart';

import '../../domain/entities/out_of_office.dart';
import '../../domain/usecases/get_out_of_office_list.dart';
import '../../domain/usecases/create_out_of_office.dart';
import '../../domain/usecases/update_out_of_office.dart';
import '../../domain/usecases/delete_out_of_office.dart';
import '../../data/models/out_of_office_request.dart';
import '../../../../core/storage/user_session.dart';

class OutOfOfficeController extends ChangeNotifier {
  final GetOutOfOfficeListUseCase _getOutOfOfficeList;
  final CreateOutOfOfficeUseCase _createOutOfOffice;
  final UpdateOutOfOfficeUseCase _updateOutOfOffice;
  final DeleteOutOfOfficeUseCase _deleteOutOfOffice;
  final UserSession _session;
  final GetAttendanceHistoryUseCase _getAttendanceHistoryUseCase;
  final GetLeaveListUseCase _getLeaveListUseCase;

  OutOfOfficeController({
    required GetOutOfOfficeListUseCase getOutOfOfficeList,
    required CreateOutOfOfficeUseCase createOutOfOffice,
    required UpdateOutOfOfficeUseCase updateOutOfOffice,
    required DeleteOutOfOfficeUseCase deleteOutOfOffice,
    required UserSession userSession,
    required GetAttendanceHistoryUseCase getAttendanceHistoryUseCase,
    required GetLeaveListUseCase getLeaveListUseCase,
  }) : _getOutOfOfficeList = getOutOfOfficeList,
       _createOutOfOffice = createOutOfOffice,
       _updateOutOfOffice = updateOutOfOffice,
       _deleteOutOfOffice = deleteOutOfOffice,
       _session = userSession,
       _getAttendanceHistoryUseCase = getAttendanceHistoryUseCase,
       _getLeaveListUseCase = getLeaveListUseCase;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<OutOfOffice> _outOfOffices = [];
  List<OutOfOffice> get outOfOffices => _outOfOffices;

  bool _isOwner = false;
  bool get isOwner => _isOwner;

  Future<void> init() async {
    final session = await _session.readSession();
    final role = (session?['role_name'] as String?)?.trim().toLowerCase();
    _isOwner = role == 'owner';
    notifyListeners();
    await fetchOutOfOffices();
  }

  Future<void> fetchOutOfOffices() async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _getOutOfOfficeList();

    if (res.isSuccess) {
      _outOfOffices = res.data ?? [];
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memuat data dinas luar';
    }

    _setLoading(false);
  }

  Future<bool> submitOutOfOffice({
    required String startDate,
    required String endDate,
    required String description,
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
    final leaveRes = await _getLeaveListUseCase();
    if (leaveRes.isSuccess && leaveRes.data != null) {
      for (final l in leaveRes.data!) {
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
    }

    // 3. Check Out of Office overlaps
    for (final o in _outOfOffices) {
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

    final req = OutOfOfficeRequest(
      startDate: startDate,
      endDate: endDate,
      description: description,
      status: 'pending',
    );

    final res = await _createOutOfOffice(req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOutOfOffices(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal mengajukan dinas luar';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStatus(int id, String status) async {
    _setLoading(true);
    _errorMessage = null;

    final req = OutOfOfficeRequest(status: status);
    final res = await _updateOutOfOffice(id, req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOutOfOffices(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memperbarui status dinas luar';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteOutOfOffice(int id) async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _deleteOutOfOffice(id);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOutOfOffices(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal menghapus dinas luar';
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
