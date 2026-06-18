import '../../../../core/network/api_response.dart';
import '../repositories/attendance_repository.dart';

/// DELETE /attendance/delete/:attendanceId
class DeleteAttendanceUseCase {
  final AttendanceRepository _repo;
  const DeleteAttendanceUseCase(this._repo);

  Future<ApiResponse<int>> call(int attendanceId) {
    return _repo.deleteAttendance(attendanceId);
  }
}
