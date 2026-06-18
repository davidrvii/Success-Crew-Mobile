import '../../../../core/network/api_response.dart';
import '../../data/models/checkout_request.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';

class CheckOutUseCase {
  final AttendanceRepository _repo;
  const CheckOutUseCase(this._repo);

  /// [date] — "YYYY-MM-DD" (defaults to today on server if omitted)
  Future<ApiResponse<Attendance>> call({String? date}) {
    final req = CheckOutRequest(date: date);
    return _repo.checkOut(req);
  }
}
