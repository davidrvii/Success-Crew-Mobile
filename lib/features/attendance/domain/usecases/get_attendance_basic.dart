/// File: lib/features/attendance/domain/usecases/get_attendance_basic.dart
/// Generated Documentation for get_attendance_basic.dart

import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// GET /attendance/basic?date=YYYY-MM-DD
/// Returns today's check-in/check-out times
/// Class representing `GetAttendanceBasicUseCase`.
/// Auto-generated class documentation.
class GetAttendanceBasicUseCase {
  final AttendanceRepository _repo;
  const GetAttendanceBasicUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<AttendanceBasic>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AttendanceBasic>> call({String? date}) {
    return _repo.getAttendanceBasic(date: date);
  }
}
