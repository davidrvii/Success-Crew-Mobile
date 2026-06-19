/// File: lib/features/attendance/domain/usecases/get_attendance_detail.dart
/// Generated Documentation for get_attendance_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// Class representing `GetAttendanceDetailUseCase`.
/// Auto-generated class documentation.
class GetAttendanceDetailUseCase {
  final AttendanceRepository _repo;
  const GetAttendanceDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<Attendance>> call(int id) {
    return _repo.getAttendanceDetail(id);
  }
}
