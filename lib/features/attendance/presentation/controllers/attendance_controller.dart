import 'package:flutter/foundation.dart';

import '../../../../core/storage/user_session.dart';

import '../../domain/entities/attendance.dart';
import '../../domain/usecases/checkin.dart';
import '../../domain/usecases/checkout.dart';
import '../../domain/usecases/get_attendance_detail.dart';
import '../../domain/usecases/get_attendance_history.dart';

class AttendanceController extends ChangeNotifier {
  final UserSession _session;
  final CheckInUseCase _checkInUseCase;
  final CheckOutUseCase _checkOutUseCase;
  final GetAttendanceDetailUseCase _getAttendanceDetailUseCase;
  final GetAttendanceHistoryUseCase _getAttendanceHistoryUseCase;

  AttendanceController({
    required UserSession session,
    required CheckInUseCase checkInUseCase,
    required CheckOutUseCase checkOutUseCase,
    required GetAttendanceDetailUseCase getAttendanceDetailUseCase,
    required GetAttendanceHistoryUseCase getAttendanceHistoryUseCase,
  }) : _session = session,
       _checkInUseCase = checkInUseCase,
       _checkOutUseCase = checkOutUseCase,
       _getAttendanceDetailUseCase = getAttendanceDetailUseCase,
       _getAttendanceHistoryUseCase = getAttendanceHistoryUseCase;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _todayAttendanceId;
  int? get todayAttendanceId => _todayAttendanceId;

  Attendance? _attendance;
  Attendance? get attendance => _attendance;

  bool get hasTodayRecord => _todayAttendanceId != null;

  // Session user details
  String _userName = 'Rahman Suratman';
  String get userName => _userName;

  String _roleName = 'Teknisi';
  String get roleName => _roleName;

  // Attendance stats
  int _presentCount = 0;
  int get presentCount => _presentCount;

  int _lateCount = 0;
  int get lateCount => _lateCount;

  int _leaveCount = 0;
  int get leaveCount => _leaveCount;

  int _overtimeCount = 0;
  int get overtimeCount => _overtimeCount;

  // Pagination fields
  List<Attendance> _allHistory = [];
  List<Attendance> _displayedHistory = [];
  List<Attendance> get history => _displayedHistory;

  int _currentPage = 1;
  final int _pageSize = 5;

  bool _hasMore = false;
  bool get hasMore => _hasMore;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> init() => refresh();

  Future<void> refresh() async {
    _setLoading(true);
    _errorMessage = null;

    // Load session info
    try {
      final session = await _session.readSession();
      if (session != null) {
        _userName = session['user_name']?.toString() ?? 'Rahman Suratman';
        _roleName = session['role_name']?.toString() ?? 'Teknisi';
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

  Future<void> checkIn() async {
    _setLoading(true);
    _errorMessage = null;

    final now = DateTime.now();
    final dateStr =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    // Determine status based on 09:00 limit
    final attendanceStatus = now.hour < 9 ? 'Hadir' : 'Telat';

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

  Future<void> checkOut() async {
    _setLoading(true);
    _errorMessage = null;

    final now = DateTime.now();
    final dateStr =
        '${now.year.toString().padLeft(4, '0')}-'
        '${now.month.toString().padLeft(2, '0')}-'
        '${now.day.toString().padLeft(2, '0')}';

    final res = await _checkOutUseCase(date: dateStr);

    if (res.isSuccess && res.data != null) {
      _attendance = res.data;
      await refresh();
      return;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal melakukan check-out.';
    }
    _setLoading(false);
  }

  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
