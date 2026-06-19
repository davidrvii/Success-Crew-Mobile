/// File: lib/features/attendance/domain/repositories/attendance_repository.dart
/// Generated Documentation for attendance_repository.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/checkin_request.dart';
import '../../data/models/checkout_request.dart';
import '../../data/models/add_attendance_request.dart';
import '../../data/models/update_attendance_request.dart';
import '../entities/attendance.dart';

abstract class AttendanceRepository {
  /// Get all attendance records (admin/owner) — GET /attendance/all
  /// Method `getAllAttendance` returning `Future<ApiResponse<List<Attendance>>>`.
  /// Handles logic operations related to `getAllAttendance`.
  Future<ApiResponse<List<Attendance>>> getAllAttendance();

  /// Get today's check-in/out status — GET /attendance/basic
  /// Method `getAttendanceBasic` returning `Future<ApiResponse<AttendanceBasic>>`.
  /// Handles logic operations related to `getAttendanceBasic`.
  Future<ApiResponse<AttendanceBasic>> getAttendanceBasic({String? date});

  /// Get crew full history with stats — GET /attendance/crew/:userId
  /// Method `getCrewAttendanceHistory` returning `Future<ApiResponse<CrewAttendanceHistory>>`.
  /// Handles logic operations related to `getCrewAttendanceHistory`.
  Future<ApiResponse<CrewAttendanceHistory>> getCrewAttendanceHistory(
    int userId,
  );

  /// Legacy: used by existing controller — wraps getCrewAttendanceHistory
  /// Method `getAttendanceHistory` returning `Future<ApiResponse<AttendanceHistoryData>>`.
  /// Handles logic operations related to `getAttendanceHistory`.
  Future<ApiResponse<AttendanceHistoryData>> getAttendanceHistory();

  /// Get attendance detail — GET /attendance/detail/:id
  /// Method `getAttendanceDetail` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `getAttendanceDetail`.
  Future<ApiResponse<Attendance>> getAttendanceDetail(int id);

  /// Add attendance (admin) — POST /attendance/add
  /// Method `addAttendance` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `addAttendance`.
  Future<ApiResponse<Attendance>> addAttendance(AddAttendanceRequest request);

  /// Check-in — PATCH /attendance/checkin
  /// Method `checkIn` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `checkIn`.
  Future<ApiResponse<Attendance>> checkIn(CheckInRequest request);

  /// Check-out — PATCH /attendance/checkout
  /// Method `checkOut` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `checkOut`.
  Future<ApiResponse<Attendance>> checkOut(CheckOutRequest request);

  /// Update attendance (admin) — PUT /attendance/update/:id
  /// Method `updateAttendance` returning `Future<ApiResponse<Attendance>>`.
  /// Handles logic operations related to `updateAttendance`.
  Future<ApiResponse<Attendance>> updateAttendance(
    int attendanceId,
    UpdateAttendanceRequest request,
  );

  /// Delete attendance — DELETE /attendance/delete/:id
  /// Method `deleteAttendance` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteAttendance`.
  Future<ApiResponse<int>> deleteAttendance(int id);
}
