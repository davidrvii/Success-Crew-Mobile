import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceDetailUseCase {
  final AttendanceRepository _repo;
  const GetAttendanceDetailUseCase(this._repo);

  Future<ApiResponse<Attendance>> call(int id) {
    return _repo.getAttendanceDetail(id);
  }
}
