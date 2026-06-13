import '../../../../core/network/api_response.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class GetAttendanceHistoryUseCase {
  final AttendanceRepository _repo;
  const GetAttendanceHistoryUseCase(this._repo);

  Future<ApiResponse<AttendanceHistoryData>> call() {
    return _repo.getAttendanceHistory();
  }
}
