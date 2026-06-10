class HomeAttendanceResponse {
  final int present;
  final int late;
  final int leave;
  final int overtime;

  HomeAttendanceResponse({
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
  });

  factory HomeAttendanceResponse.fromJson(Map<String, dynamic> json) {
    return HomeAttendanceResponse(
      present: (json['present'] as num?)?.toInt() ?? 0,
      late: (json['late'] as num?)?.toInt() ?? 0,
      leave: (json['leave'] as num?)?.toInt() ?? 0,
      overtime: (json['overtime'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'present': present,
      'late': late,
      'leave': leave,
      'overtime': overtime,
    };
  }
}
