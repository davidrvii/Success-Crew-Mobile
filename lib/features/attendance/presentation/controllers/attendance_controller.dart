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

  // History list
  List<Attendance> _history = [];
  List<Attendance> get history => _history;

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

    // Load today's attendance details
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
      _history = data.history;
      _presentCount = data.presentCount;
      _lateCount = data.lateCount;
      _leaveCount = data.leaveCount;
      _overtimeCount = data.overtimeCount;

      // Fallback/Auto-creation: If not found in session, look in history for today's check-in
      if (_attendance == null) {
        final now = DateTime.now();
        Attendance? todayEntry;
        // 1st pass: Look for today's entry that already has a check-in time
        for (final a in _history) {
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
        // 2nd pass: Look for any today's entry (e.g. pre-created / absent)
        if (todayEntry == null) {
          for (final a in _history) {
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
        } else {
          // 1. Create today's attendance record without check-in and check-out times
          final createRes = await _checkInUseCase(
            status: 'Tidak Hadir',
            attendanceDate: now,
            checkInAt: null,
          );
          if (createRes.isSuccess && createRes.data != null) {
            final newRecord = createRes.data!;
            _attendance = newRecord;
            _todayAttendanceId = newRecord.id;
            await _session.saveTodayAttendanceId(newRecord.id);
            _history = [newRecord, ..._history];
          } else if (createRes.error != null) {
            _errorMessage = createRes.error?.message;
          }
        }
      }
    } else if (historyRes.error != null) {
      _errorMessage ??= historyRes.error?.message;
    }

    _setLoading(false);
  }

  Future<void> checkIn() async {
    if (_todayAttendanceId == null) {
      _errorMessage = 'Gagal melakukan check-in: data absensi belum diinisialisasi.';
      notifyListeners();
      return;
    }

    _setLoading(true);
    _errorMessage = null;

    // Determine status based on 09:00 WIB limit
    final now = DateTime.now();
    final status = now.hour < 9 ? 'Tepat Waktu' : 'Telat';

    // 2. Update existing record with check-in time and status
    final res = await _checkOutUseCase(
      _todayAttendanceId!,
      status: status,
      checkInAt: now,
      checkOutAt: null,
    );

    if (res.isSuccess) {
      _attendance = res.data;
      await refresh();
      return;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal melakukan check-in.';
    }
    _setLoading(false);
  }

  Future<void> checkOut() async {
    if (_todayAttendanceId == null) {
      _errorMessage = 'Belum melakukan check-in hari ini.';
      notifyListeners();
      return;
    }

    _setLoading(true);
    _errorMessage = null;

    final now = DateTime.now();

    // 3. Update existing record with check-out time
    final res = await _checkOutUseCase(
      _todayAttendanceId!,
      checkOutAt: now,
    );

    if (res.isSuccess) {
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
