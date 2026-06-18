class OvertimeRequest {
  final int? userId;
  final int? attendanceId;

  final String? overtimeDate;
  final String? startTime;
  final String? endTime;

  final String? reason;
  final String? status;

  const OvertimeRequest({
    this.userId,
    this.attendanceId,
    this.overtimeDate,
    this.startTime,
    this.endTime,
    this.reason,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (userId != null) {
      map['user_id'] = userId;
      map['userId'] = userId;
    }

    if (attendanceId != null) {
      map['attendance_id'] = attendanceId;
      map['attendanceId'] = attendanceId;
    }

    if (overtimeDate != null && overtimeDate!.isNotEmpty) {
      map['overtime_date'] = overtimeDate;
      map['date'] = overtimeDate;
    }

    if (startTime != null && startTime!.isNotEmpty) {
      map['start_time'] = startTime;
      map['startTime'] = startTime;
      map['overtime_start'] = startTime;
    }

    if (endTime != null && endTime!.isNotEmpty) {
      map['end_time'] = endTime;
      map['endTime'] = endTime;
      map['overtime_end'] = endTime;
    }

    if (reason != null && reason!.isNotEmpty) {
      map['reason'] = reason;
      map['overtime_reason'] = reason;
      map['overtime_desc'] = reason;
    }

    if (status != null && status!.isNotEmpty) {
      map['status'] = status;
      map['overtime_status'] = status;
    }

    return map;
  }
}
