import 'package:flutter/foundation.dart';

import '../../../../core/storage/user_session.dart';

import '../../domain/entities/attendance.dart';
import '../../domain/usecases/checkin.dart';
import '../../domain/usecases/checkout.dart';
import '../../domain/usecases/get_attendance_detail.dart';

class AttendanceController extends ChangeNotifier {
  final UserSession _session;
  final CheckInUseCase _checkInUseCase;
  final CheckOutUseCase _checkOutUseCase;
  final GetAttendanceDetailUseCase _getAttendanceDetailUseCase;

  AttendanceController({
    required UserSession session,
    required CheckInUseCase checkInUseCase,
    required CheckOutUseCase checkOutUseCase,
    required GetAttendanceDetailUseCase getAttendanceDetailUseCase,
  }) : _session = session,
       _checkInUseCase = checkInUseCase,
       _checkOutUseCase = checkOutUseCase,
       _getAttendanceDetailUseCase = getAttendanceDetailUseCase;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  int? _todayAttendanceId;
  int? get todayAttendanceId => _todayAttendanceId;

  Attendance? _attendance;
  Attendance? get attendance => _attendance;

  bool get hasTodayRecord => _todayAttendanceId != null;

  Future<void> init() => refresh();

  Future<void> refresh() async {
    _setLoading(true);
    _errorMessage = null;

    _todayAttendanceId = await _session.readTodayAttendanceId();

    if (_todayAttendanceId != null) {
      final res = await _getAttendanceDetailUseCase(_todayAttendanceId!);
      if (res.isSuccess) {
        _attendance = res.data;
      } else {
        _attendance = null;
        _errorMessage = res.error?.message;
      }
    } else {
      _attendance = null;
    }

    _setLoading(false);
  }

  Future<void> checkIn() async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _checkInUseCase();

    if (res.isSuccess) {
      final dto = res.data;
      if (dto != null && dto.id != 0) {
        _todayAttendanceId = dto.id;
        _attendance = dto;
      }
    } else {
      _errorMessage = res.error?.message ?? 'Gagal melakukan check-in.';
    }

    _setLoading(false);
  }

  Future<void> checkOut() async {
    if (_todayAttendanceId == null) {
      _errorMessage = 'Tidak ada ID attendance aktif untuk check-out.';
      notifyListeners();
      return;
    }

    _setLoading(true);
    _errorMessage = null;

    final res = await _checkOutUseCase(_todayAttendanceId!);

    if (res.isSuccess) {
      _attendance = res.data;
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
