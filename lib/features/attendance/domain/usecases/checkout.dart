import '../../../../core/network/api_response.dart';
import '../../data/models/checkout_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class CheckOutUseCase {
  final AttendanceRepository _repo;
  const CheckOutUseCase(this._repo);

  Future<ApiResponse<Attendance>> call(
    int attendanceId, {
    String? status,
    DateTime? checkInAt,
    DateTime? checkOutAt,
  }) {
    final req = CheckOutRequest(
      status: status,
      checkInAt: checkInAt,
      checkOutAt: checkOutAt,
    );
    return _repo.checkOut(attendanceId, req);
  }
}
