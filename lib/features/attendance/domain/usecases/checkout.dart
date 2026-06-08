import '../../../../core/network/api_response.dart';
import '../../data/models/checkout_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class CheckOutUseCase {
  final AttendanceRepository _repo;
  const CheckOutUseCase(this._repo);

  Future<ApiResponse<Attendance>> call(int attendanceId, {String? status}) {
    final req = CheckOutRequest(status: status);
    return _repo.checkOut(attendanceId, req);
  }
}
