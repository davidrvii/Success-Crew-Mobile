/// File: lib/features/attendance/presentation/controllers/attendance_controller.dart
/// Generated Documentation for attendance_controller.dart

import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../core/storage/user_session.dart';
import '../../../../core/utils/location_helper.dart';
import '../../../../core/utils/date_overlap_helper.dart';

import '../../../leave/domain/usecases/get_leave_list.dart';
import '../../../out_of_office/domain/usecases/get_out_of_office_list.dart';

import '../../domain/entities/attendance.dart';
import '../../domain/usecases/checkin.dart';
import '../../domain/usecases/checkout.dart';
import '../../domain/usecases/get_attendance_detail.dart';
import '../../domain/usecases/get_attendance_history.dart';

/// Class representing `AttendanceController`.
/// Auto-generated class documentation.
class AttendanceController extends ChangeNotifier {
  final UserSession _session;
  final CheckInUseCase _checkInUseCase;
  final CheckOutUseCase _checkOutUseCase;
  final GetAttendanceDetailUseCase _getAttendanceDetailUseCase;
  final GetAttendanceHistoryUseCase _getAttendanceHistoryUseCase;
  final GetLeaveListUseCase _getLeaveListUseCase;
  final GetOutOfOfficeListUseCase _getOutOfOfficeListUseCase;

  AttendanceController({
    required UserSession session,
    required CheckInUseCase checkInUseCase,
    required CheckOutUseCase checkOutUseCase,
    required GetAttendanceDetailUseCase getAttendanceDetailUseCase,
    required GetAttendanceHistoryUseCase getAttendanceHistoryUseCase,
    required GetLeaveListUseCase getLeaveListUseCase,
    required GetOutOfOfficeListUseCase getOutOfOfficeListUseCase,
  }) : _session = session,
       _checkInUseCase = checkInUseCase,
       _checkOutUseCase = checkOutUseCase,
       _getAttendanceDetailUseCase = getAttendanceDetailUseCase,
       _getAttendanceHistoryUseCase = getAttendanceHistoryUseCase,
       _getLeaveListUseCase = getLeaveListUseCase,
       _getOutOfOfficeListUseCase = getOutOfOfficeListUseCase;

  bool _loading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _loading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  int? _todayAttendanceId;
  /// Getter for `todayAttendanceId` returning `int?`.
  int? get todayAttendanceId => _todayAttendanceId;

  Attendance? _attendance;
  /// Getter for `attendance` returning `Attendance?`.
  Attendance? get attendance => _attendance;

  /// Getter for `hasTodayRecord` returning `bool`.
  bool get hasTodayRecord => _todayAttendanceId != null;

  // Session user details
  String _userName = '-';
  /// Getter for `userName` returning `String`.
  String get userName => _userName;

  String _roleName = '-';
  /// Getter for `roleName` returning `String`.
  String get roleName => _roleName;

  /// Method `_toTitleCase` returning `String`.
  /// Handles logic operations related to `_toTitleCase`.
  String _toTitleCase(String? s) {
    if (s == null || s.trim().isEmpty) return '-';
    return s.trim().split(' ').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }

  // Attendance stats
  int _presentCount = 0;
  /// Getter for `presentCount` returning `int`.
  int get presentCount => _presentCount;

  int _lateCount = 0;
  /// Getter for `lateCount` returning `int`.
  int get lateCount => _lateCount;

  int _leaveCount = 0;
  /// Getter for `leaveCount` returning `int`.
  int get leaveCount => _leaveCount;

  int _overtimeCount = 0;
  /// Getter for `overtimeCount` returning `int`.
  int get overtimeCount => _overtimeCount;

  int _outOfOfficeCount = 0;
  /// Getter for `outOfOfficeCount` returning `int`.
  int get outOfOfficeCount => _outOfOfficeCount;

  // Pagination fields
  List<Attendance> _allHistory = [];
  List<Attendance> _displayedHistory = [];
  /// Getter for `history` returning `List<Attendance>`.
  List<Attendance> get history => _displayedHistory;

  int _currentPage = 1;
  final int _pageSize = 5;

  bool _hasMore = false;
  /// Getter for `hasMore` returning `bool`.
  bool get hasMore => _hasMore;

  bool _isLoadingMore = false;
  /// Getter for `isLoadingMore` returning `bool`.
  bool get isLoadingMore => _isLoadingMore;

  /// Method `init` returning `Future<void>`.
  /// Handles logic operations related to `init`.
  Future<void> init() async {
    await refresh();
    _checkAutoCheckout();
    startAutoCheckoutTimer();
  }

  /// Method `refresh` returning `Future<void>`.
  /// Handles logic operations related to `refresh`.
  Future<void> refresh() async {
    _setLoading(true);
    _errorMessage = null;

    // Load session info
    try {
      final session = await _session.readSession();
      if (session != null) {
        _userName = session['user_name']?.toString().trim().isNotEmpty == true
            ? session['user_name']!.toString()
            : '-';
        final rawRole = session['role_name']?.toString();
        _roleName = (rawRole != null && rawRole.trim().isNotEmpty)
            ? _toTitleCase(rawRole)
            : '-';
      }
    } catch (_) {}

    // Load today's attendance from session cache
    _todayAttendanceId = await _session.readTodayAttendanceId();

    if (_todayAttendanceId != null) {
      final res = await _getAttendanceDetailUseCase(_todayAttendanceId!);
      if (res.isSuccess) {
        _attendance = res.data;
      } else {
        _todayAttendanceId = null;
        _attendance = null;
      }
    } else {
      _attendance = null;
    }

    // Load attendance history & stats
    final historyRes = await _getAttendanceHistoryUseCase();
    if (historyRes.isSuccess && historyRes.data != null) {
      final data = historyRes.data!;
      _allHistory = data.history;
      _presentCount = data.presentCount;
      _lateCount = data.lateCount;
      _leaveCount = data.leaveCount;
      _overtimeCount = data.overtimeCount;
      _outOfOfficeCount = data.outOfOfficeCount;

      // Find today's entry from history if not yet loaded from session
      if (_attendance == null) {
        final now = DateTime.now();
        Attendance? todayEntry;

        for (final a in _allHistory) {
          if (a.attendanceDate != null) {
            final date = a.attendanceDate!.toLocal();
            if (date.year == now.year &&
                date.month == now.month &&
                date.day == now.day &&
                a.checkInAt != null) {
              todayEntry = a;
              break;
            }
          }
        }
        // 2nd pass: any today entry (pre-created)
        if (todayEntry == null) {
          for (final a in _allHistory) {
            if (a.attendanceDate != null) {
              final date = a.attendanceDate!.toLocal();
              if (date.year == now.year &&
                  date.month == now.month &&
                  date.day == now.day) {
                todayEntry = a;
                break;
              }
            }
          }
        }

        if (todayEntry != null) {
          _attendance = todayEntry;
          _todayAttendanceId = todayEntry.id;
          await _session.saveTodayAttendanceId(todayEntry.id);
        }
      }

      // Pagination setup
      _currentPage = 1;
      _displayedHistory = _allHistory.take(_pageSize).toList();
      _hasMore = _allHistory.length > _pageSize;
      _isLoadingMore = false;
    } else if (historyRes.error != null) {
      _errorMessage ??= historyRes.error?.message;
    }

    _setLoading(false);
  }

  /// Method `loadMore` returning `Future<void>`.
  /// Handles logic operations related to `loadMore`.
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    final int nextOffset = _currentPage * _pageSize;
    final nextItems = _allHistory.skip(nextOffset).take(_pageSize).toList();

    _displayedHistory.addAll(nextItems);
    _currentPage++;
    _hasMore = _displayedHistory.length < _allHistory.length;

    _isLoadingMore = false;
    notifyListeners();
  }

  /// Performs the employee check-in operation.
  /// 
  /// Performs key safety and range checks before submitting:
  /// 1. GPS geofence check (must be within 150m of shop coordinates).
  /// 2. Verifies there are no approved/pending leave requests on this date.
  /// 3. Verifies there are no approved/pending out-of-office (dinas) assignments on this date.
  /// 4. Verifies the employee has not already checked in today.
  /// Method `checkIn` returning `Future<void>`.
  /// Handles logic operations related to `checkIn`.
  Future<void> checkIn() async {
    _setLoading(true);
    _errorMessage = null;

    // 1. Geofencing check
    final inRange = await LocationHelper.isWithinRange();
    if (!inRange) {
      _errorMessage = 'Diluar jangkauan lokasi toko';
      _setLoading(false);
      return;
    }

    final now = DateTime.now();

    // 2. Cross-verify today's date with leave records to prevent duplicates
    final leaveRes = await _getLeaveListUseCase();
    if (leaveRes.isSuccess && leaveRes.data != null) {
      for (final l in leaveRes.data!) {
        final status = (l.status ?? '').toLowerCase().trim();
        if (status == 'rejected' || status == 'ditolak') continue;
        if (l.startDate != null && l.endDate != null) {
          if (DateOverlapHelper.isDateInRange(now, l.startDate!, l.endDate!)) {
            _errorMessage = 'Terdapat cuti pada tanggal tersebut';
            _setLoading(false);
            return;
          }
        }
      }
    }

    // 3. Cross-verify today's date with out-of-office assignments
    final oooRes = await _getOutOfOfficeListUseCase();
    if (oooRes.isSuccess && oooRes.data != null) {
      for (final o in oooRes.data!) {
        final status = (o.status ?? '').toLowerCase().trim();
        if (status == 'rejected' || status == 'ditolak') continue;
        if (o.startDate != null && o.endDate != null) {
          if (DateOverlapHelper.isDateInRange(now, o.startDate!, o.endDate!)) {
            _errorMessage = 'Terdapat dinas pada tanggal tersebut';
            _setLoading(false);
            return;
          }
        }
      }
    }

    // 4. Ensure no existing check-in has already been registered for today
    if (_allHistory.isNotEmpty) {
      final normalizedToday = DateOverlapHelper.normalize(now);
      for (final h in _allHistory) {
        if (h.attendanceDate != null && h.checkInAt != null) {
          final normalizedAtt = DateOverlapHelper.normalize(h.attendanceDate!);
          if (normalizedToday.isAtSameMomentAs(normalizedAtt)) {
            _errorMessage = 'Terdapat absensi pada tanggal tersebut';
            _setLoading(false);
            return;
          }
        }
      }
    }

    // Format local date representation for API payload
    final dateStr =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    // Assign status depending on whether check-in is before or after 09:00 limit
    final attendanceStatus = now.hour < 9 ? 'Tepat Waktu' : 'Telat';

    // Execute check-in API call
    final res = await _checkInUseCase(
      date: dateStr,
      attendanceStatus: attendanceStatus,
    );

    if (res.isSuccess && res.data != null) {
      _attendance = res.data;
      if (res.data!.id != 0) {
        _todayAttendanceId = res.data!.id;
        await _session.saveTodayAttendanceId(res.data!.id);
      }
      await refresh();
      return;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal melakukan check-in.';
    }
    _setLoading(false);
  }

  /// Performs the employee check-out operation.
  /// 
  /// Validates the GPS geofence before calling the check-out endpoint.
  /// Method `checkOut` returning `Future<void>`.
  /// Handles logic operations related to `checkOut`.
  Future<void> checkOut({String? date}) async {
    _setLoading(true);
    _errorMessage = null;

    // Verify GPS coordinates are within 150m range of the shop
    final inRange = await LocationHelper.isWithinRange();
    if (!inRange) {
      _errorMessage = 'Diluar jangkauan lokasi toko';
      _setLoading(false);
      return;
    }

    // Fallback to today's date string if not explicitly specified
    final targetDate = date ?? () {
      final now = DateTime.now();
      return '${now.year.toString().padLeft(4, '0')}-'
             '${now.month.toString().padLeft(2, '0')}-'
             '${now.day.toString().padLeft(2, '0')}';
    }();

    // Execute check-out API call
    final res = await _checkOutUseCase(date: targetDate);

    if (res.isSuccess && res.data != null) {
      _attendance = res.data;
      await refresh();
      return;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal melakukan check-out.';
    }
    _setLoading(false);
  }

  Timer? _autoCheckoutTimer;

  /// Method `startAutoCheckoutTimer` returning `void`.
  /// Handles logic operations related to `startAutoCheckoutTimer`.
  void startAutoCheckoutTimer() {
    _autoCheckoutTimer?.cancel();
    _autoCheckoutTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkAutoCheckout();
    });
  }

  /// Method `_checkAutoCheckout` returning `void`.
  /// Handles logic operations related to `_checkAutoCheckout`.
  void _checkAutoCheckout() {
    final att = _attendance;
    if (att != null && att.checkInAt != null && att.checkOutAt == null) {
      final now = DateTime.now();
      if (att.attendanceDate != null) {
        final checkInDate = att.attendanceDate!.toLocal();
        final today = DateTime(now.year, now.month, now.day);
        final checkInDay = DateTime(checkInDate.year, checkInDate.month, checkInDate.day);
        if (today.isAfter(checkInDay)) {
          final dateStr =
              '${checkInDay.year.toString().padLeft(4, '0')}-'
              '${checkInDay.month.toString().padLeft(2, '0')}-'
              '${checkInDay.day.toString().padLeft(2, '0')}';
          checkOut(date: dateStr);
        }
      }
    }
  }

  @override
  /// Method `dispose` returning `void`.
  /// Handles logic operations related to `dispose`.
  void dispose() {
    _autoCheckoutTimer?.cancel();
    super.dispose();
  }

  /// Method `_setLoading` returning `void`.
  /// Handles logic operations related to `_setLoading`.
  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
