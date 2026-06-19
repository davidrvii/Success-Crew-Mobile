/// File: lib/features/attendance/domain/usecases/get_attendance_history.dart
/// Generated Documentation for get_attendance_history.dart

import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// Class representing `GetAttendanceHistoryUseCase`.
/// Auto-generated class documentation.
class GetAttendanceHistoryUseCase {
  final AttendanceRepository _repo;
  const GetAttendanceHistoryUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<AttendanceHistoryData>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AttendanceHistoryData>> call() {
    return _repo.getAttendanceHistory();
  }
}
