/// File: lib/features/attendance/domain/usecases/get_all_attendance.dart
/// Generated Documentation for get_all_attendance.dart

import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// GET /attendance/all — admin gets all attendance records
/// Class representing `GetAllAttendanceUseCase`.
/// Auto-generated class documentation.
class GetAllAttendanceUseCase {
  final AttendanceRepository _repo;
  const GetAllAttendanceUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<Attendance>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<Attendance>>> call() {
    return _repo.getAllAttendance();
  }
}
