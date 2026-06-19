/// File: lib/features/attendance/domain/usecases/update_attendance.dart
/// Generated Documentation for update_attendance.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/update_attendance_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// PUT /attendance/update/:attendanceId — admin updates attendance record
/// Class representing `UpdateAttendanceUseCase`.
/// Auto-generated class documentation.
class UpdateAttendanceUseCase {
  final AttendanceRepository _repo;
  const UpdateAttendanceUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Attendance>> call(
    int attendanceId, {
    String? attendanceStatus,
    String? attendanceIn,
    String? attendanceOut,
    String? attendanceDate,
  }) {
    final req = UpdateAttendanceRequest(
      attendanceStatus: attendanceStatus,
      attendanceIn: attendanceIn,
      attendanceOut: attendanceOut,
      attendanceDate: attendanceDate,
    );
    return _repo.updateAttendance(attendanceId, req);
  }
}
