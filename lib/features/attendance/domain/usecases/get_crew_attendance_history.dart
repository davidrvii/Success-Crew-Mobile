import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// GET /attendance/crew/:userId
/// Returns full crew history with stats and mixed-type history entries
class GetCrewAttendanceHistoryUseCase {
  final AttendanceRepository _repo;
  const GetCrewAttendanceHistoryUseCase(this._repo);

  Future<ApiResponse<CrewAttendanceHistory>> call(int userId) {
    return _repo.getCrewAttendanceHistory(userId);
  }
}
