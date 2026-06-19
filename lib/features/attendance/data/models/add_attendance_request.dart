/// File: lib/features/attendance/data/models/add_attendance_request.dart
/// Generated Documentation for add_attendance_request.dart

/// Request for POST /attendance/add
/// Body: { user_id: 10, attendance_date: "YYYY-MM-DD" }
/// Class representing `AddAttendanceRequest`.
/// Auto-generated class documentation.
class AddAttendanceRequest {
  final int? userId;
  final String? attendanceDate; // "YYYY-MM-DD"

  const AddAttendanceRequest({this.userId, this.attendanceDate});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userId != null) map['user_id'] = userId;
    if (attendanceDate != null && attendanceDate!.isNotEmpty) {
      map['attendance_date'] = attendanceDate;
    }
    return map;
  }
}
