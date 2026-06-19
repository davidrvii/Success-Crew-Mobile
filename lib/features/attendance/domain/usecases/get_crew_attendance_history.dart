/// File: lib/features/attendance/domain/usecases/get_crew_attendance_history.dart
/// Generated Documentation for get_crew_attendance_history.dart

import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// GET /attendance/crew/:userId
/// Returns full crew history with stats and mixed-type history entries
/// Class representing `GetCrewAttendanceHistoryUseCase`.
/// Auto-generated class documentation.
class GetCrewAttendanceHistoryUseCase {
  final AttendanceRepository _repo;
  const GetCrewAttendanceHistoryUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<CrewAttendanceHistory>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<CrewAttendanceHistory>> call(int userId) {
    return _repo.getCrewAttendanceHistory(userId);
  }
}
