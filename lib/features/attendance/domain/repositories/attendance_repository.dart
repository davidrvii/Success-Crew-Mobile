import '../../../../core/network/api_response.dart';
import '../../data/models/checkin_request.dart';
import '../../data/models/checkout_request.dart';
import '../../data/models/add_attendance_request.dart';
import '../../data/models/update_attendance_request.dart';
import '../entities/attendance.dart';

abstract class AttendanceRepository {
  /// Get all attendance records (admin/owner) — GET /attendance/all
  Future<ApiResponse<List<Attendance>>> getAllAttendance();

  /// Get today's check-in/out status — GET /attendance/basic
  Future<ApiResponse<AttendanceBasic>> getAttendanceBasic({String? date});

  /// Get crew full history with stats — GET /attendance/crew/:userId
  Future<ApiResponse<CrewAttendanceHistory>> getCrewAttendanceHistory(
    int userId,
  );

  /// Legacy: used by existing controller — wraps getCrewAttendanceHistory
  Future<ApiResponse<AttendanceHistoryData>> getAttendanceHistory();

  /// Get attendance detail — GET /attendance/detail/:id
  Future<ApiResponse<Attendance>> getAttendanceDetail(int id);

  /// Add attendance (admin) — POST /attendance/add
  Future<ApiResponse<Attendance>> addAttendance(AddAttendanceRequest request);

  /// Check-in — PATCH /attendance/checkin
  Future<ApiResponse<Attendance>> checkIn(CheckInRequest request);

  /// Check-out — PATCH /attendance/checkout
  Future<ApiResponse<Attendance>> checkOut(CheckOutRequest request);

  /// Update attendance (admin) — PUT /attendance/update/:id
  Future<ApiResponse<Attendance>> updateAttendance(
    int attendanceId,
    UpdateAttendanceRequest request,
  );

  /// Delete attendance — DELETE /attendance/delete/:id
  Future<ApiResponse<int>> deleteAttendance(int id);
}
