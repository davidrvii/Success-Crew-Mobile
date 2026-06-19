/// File: lib/features/attendance/domain/usecases/delete_attendance.dart
/// Generated Documentation for delete_attendance.dart

import '../../../../core/network/api_response.dart';
import '../repositories/attendance_repository.dart';

/// DELETE /attendance/delete/:attendanceId
/// Class representing `DeleteAttendanceUseCase`.
/// Auto-generated class documentation.
class DeleteAttendanceUseCase {
  final AttendanceRepository _repo;
  const DeleteAttendanceUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int attendanceId) {
    return _repo.deleteAttendance(attendanceId);
  }
}
