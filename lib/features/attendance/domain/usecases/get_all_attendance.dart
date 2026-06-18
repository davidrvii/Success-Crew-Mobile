import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// GET /attendance/all — admin gets all attendance records
class GetAllAttendanceUseCase {
  final AttendanceRepository _repo;
  const GetAllAttendanceUseCase(this._repo);

  Future<ApiResponse<List<Attendance>>> call() {
    return _repo.getAllAttendance();
  }
}
