import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

/// GET /attendance/basic?date=YYYY-MM-DD
/// Returns today's check-in/check-out times
class GetAttendanceBasicUseCase {
  final AttendanceRepository _repo;
  const GetAttendanceBasicUseCase(this._repo);

  Future<ApiResponse<AttendanceBasic>> call({String? date}) {
    return _repo.getAttendanceBasic(date: date);
  }
}
