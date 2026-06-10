class HomeAbsenceResponse {
  final int attendanceId;
  final String status;
  final String? checkIn;
  final String? checkOut;

  HomeAbsenceResponse({
    required this.attendanceId,
    required this.status,
    this.checkIn,
    this.checkOut,
  });

  factory HomeAbsenceResponse.fromJson(Map<String, dynamic> json) {
    return HomeAbsenceResponse(
      attendanceId: (json['attendance_id'] as num?)?.toInt() ?? 0,
      status: (json['attendance_status'] as String?) ?? '',
      checkIn: json['attendance_in'] as String?,
      checkOut: json['attendance_out'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'attendance_id': attendanceId,
      'attendance_status': status,
      'attendance_in': checkIn,
      'attendance_out': checkOut,
    };
  }
}
