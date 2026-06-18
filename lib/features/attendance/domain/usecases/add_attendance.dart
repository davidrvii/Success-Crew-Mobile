import '../../../../core/network/api_response.dart';
import '../../data/models/add_attendance_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// POST /attendance/add — admin creates attendance record for a user
class AddAttendanceUseCase {
  final AttendanceRepository _repo;
  const AddAttendanceUseCase(this._repo);

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
