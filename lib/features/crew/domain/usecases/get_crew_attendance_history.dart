/// File: lib/features/crew/domain/usecases/get_crew_attendance_history.dart
/// Generated Documentation for get_crew_attendance_history.dart

import '../../../../core/network/api_response.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../repositories/crew_repository.dart';

/// Class representing `GetCrewAttendanceHistoryUseCase`.
/// Auto-generated class documentation.
class GetCrewAttendanceHistoryUseCase {
  final CrewRepository _repository;
  GetCrewAttendanceHistoryUseCase(this._repository);

  /// Method `call` returning `Future<ApiResponse<AttendanceHistoryData>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AttendanceHistoryData>> call(int userId) {
    return _repository.getCrewAttendanceHistory(userId);
  }
}
