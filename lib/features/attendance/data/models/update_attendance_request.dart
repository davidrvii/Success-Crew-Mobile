/// Request for PUT /attendance/update/:attendanceId
/// Body: { attendance_status, attendance_in, attendance_out, attendance_date }
class UpdateAttendanceRequest {
  final String? attendanceStatus;
  final String? attendanceIn; // ISO datetime string
  final String? attendanceOut; // ISO datetime string
  final String? attendanceDate; // "YYYY-MM-DD"

  const UpdateAttendanceRequest({
    this.attendanceStatus,
    this.attendanceIn,
    this.attendanceOut,
    this.attendanceDate,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (attendanceStatus != null && attendanceStatus!.isNotEmpty) {
      map['attendance_status'] = attendanceStatus;
    }
    if (attendanceIn != null && attendanceIn!.isNotEmpty) {
      map['attendance_in'] = attendanceIn;
    }
    if (attendanceOut != null && attendanceOut!.isNotEmpty) {
      map['attendance_out'] = attendanceOut;
    }
    if (attendanceDate != null && attendanceDate!.isNotEmpty) {
      map['attendance_date'] = attendanceDate;
    }
    return map;
  }
}
