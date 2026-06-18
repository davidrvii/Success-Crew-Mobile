import '../../../../core/network/api_response.dart';
import '../../data/models/update_attendance_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// PUT /attendance/update/:attendanceId — admin updates attendance record
class UpdateAttendanceUseCase {
  final AttendanceRepository _repo;
  const UpdateAttendanceUseCase(this._repo);

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
