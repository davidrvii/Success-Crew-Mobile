/// File: lib/features/home/data/models/home_attendance_response.dart
/// Generated Documentation for home_attendance_response.dart

/// Class representing `HomeAttendanceResponse`.
/// Auto-generated class documentation.
class HomeAttendanceResponse {
  final int present;
  final int late;
  final int leave;
  final int overtime;
  final int outOfOffice;

  HomeAttendanceResponse({
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
    required this.outOfOffice,
  });

  factory HomeAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return HomeAttendanceResponse(
      present: (json['present'] as num?)?.toInt() ?? 0,
      late: (json['late'] as num?)?.toInt() ?? 0,
      leave: (json['leave'] as num?)?.toInt() ?? 0,
      overtime: (json['overtime'] as num?)?.toInt() ?? 0,
      outOfOffice: (json['outOfOffice'] as num?)?.toInt() ?? (json['out_of_office'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'present': present,
      'late': late,
      'leave': leave,
      'overtime': overtime,
      'outOfOffice': outOfOffice,
    };
  }
}
