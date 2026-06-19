/// File: lib/features/attendance/domain/usecases/add_attendance.dart
/// Generated Documentation for add_attendance.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/add_attendance_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// POST /attendance/add — admin creates attendance record for a user
/// Class representing `AddAttendanceUseCase`.
/// Auto-generated class documentation.
class AddAttendanceUseCase {
  final AttendanceRepository _repo;
  const AddAttendanceUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Attendance>> call({
    required int userId,
    required String attendanceDate, // "YYYY-MM-DD"
  }) {
    final req = AddAttendanceRequest(
      userId: userId,
      attendanceDate: attendanceDate,
    );
    return _repo.addAttendance(req);
  }
}
