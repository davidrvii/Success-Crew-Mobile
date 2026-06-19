/// File: lib/features/attendance/domain/usecases/checkin.dart
/// Generated Documentation for checkin.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/checkin_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// Class representing `CheckInUseCase`.
/// Auto-generated class documentation.
class CheckInUseCase {
  final AttendanceRepository _repo;
  const CheckInUseCase(this._repo);

  /// [date] — "YYYY-MM-DD" (defaults to today on server if omitted)
  /// [attendanceStatus] — e.g. "Hadir", "Telat"
  /// Method `call` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Attendance>> call({
    String? date,
    String? attendanceStatus,
  }) {
    final req = CheckInRequest(date: date, attendanceStatus: attendanceStatus);
    return _repo.checkIn(req);
  }
}
