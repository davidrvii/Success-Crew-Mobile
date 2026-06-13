class CheckInRequest {
  final String? status;
  final DateTime? attendanceDate;
  final DateTime? checkInAt;

  const CheckInRequest({
    this.status,
    this.attendanceDate,
    this.checkInAt,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (status != null && status!.isNotEmpty) {
      map['attendance_status'] = status;
    }

    if (attendanceDate != null) {
      final y = attendanceDate!.year.toString().padLeft(4, '0');
      final m = attendanceDate!.month.toString().padLeft(2, '0');
      final d = attendanceDate!.day.toString().padLeft(2, '0');
      map['attendance_date'] = '$y-$m-${d}T00:00:00.000Z';
    }

    if (checkInAt != null) {
      map['attendance_in'] = checkInAt!.toUtc().toIso8601String();
    }

    return map;
  }
}
