import '../../../../core/network/api_response.dart';
import '../../data/models/checkin_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class CheckInUseCase {
  final AttendanceRepository _repo;
  const CheckInUseCase(this._repo);

  Future<ApiResponse<Attendance>> call({String? status}) {
    final req = CheckInRequest(status: status);
    return _repo.checkIn(req);
  }
}
