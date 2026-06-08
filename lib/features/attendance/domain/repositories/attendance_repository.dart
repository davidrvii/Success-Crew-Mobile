import '../../../../core/network/api_response.dart';
import '../../data/models/checkin_request.dart';
import '../../data/models/checkout_request.dart';
import '../entities/attendance.dart';

abstract class AttendanceRepository {
  Future<ApiResponse<List<Attendance>>> getAttendanceHistory();

  Future<ApiResponse<Attendance>> getAttendanceDetail(int id);

  Future<ApiResponse<Attendance>> checkIn(CheckInRequest request);

  Future<ApiResponse<Attendance>> checkOut(
    int attendanceId,
    CheckOutRequest request,
  );
}
