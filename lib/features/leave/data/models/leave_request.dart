class LeaveRequest {
  final int? userId;

  final String? leaveType;

  final String? startDate;
  final String? endDate;

  final String? reason;

  final String? status;

  const LeaveRequest({
    this.userId,
    this.leaveType,
    this.startDate,
    this.endDate,
    this.reason,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (userId != null) {
      map['user_id'] = userId;
      map['userId'] = userId;
    }

    if (leaveType != null && leaveType!.isNotEmpty) {
      map['leave_type'] = leaveType;
      map['leaveType'] = leaveType;
      map['type'] = leaveType;
    }

    if (startDate != null && startDate!.isNotEmpty) {
      map['start_date'] = startDate;
      map['startDate'] = startDate;
    }

    if (endDate != null && endDate!.isNotEmpty) {
      map['end_date'] = endDate;
      map['endDate'] = endDate;
    }

    if (reason != null && reason!.isNotEmpty) {
      map['reason'] = reason;
      map['leave_reason'] = reason;
    }

    if (status != null && status!.isNotEmpty) {
      map['status'] = status;
      map['leave_status'] = status;
    }

    return map;
  }
}
