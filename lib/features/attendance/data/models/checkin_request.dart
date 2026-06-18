/// Request for PATCH /attendance/checkin
/// Body: { date: "YYYY-MM-DD", attendance_status: "Hadir" }
class CheckInRequest {
  /// Date string formatted as YYYY-MM-DD
  final String? date;

  /// e.g. "Hadir", "Telat"
  final String? attendanceStatus;

  const CheckInRequest({this.date, this.attendanceStatus});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (date != null && date!.isNotEmpty) map['date'] = date;
    if (attendanceStatus != null && attendanceStatus!.isNotEmpty) {
      map['attendance_status'] = attendanceStatus;
    }
    return map;
  }
}
