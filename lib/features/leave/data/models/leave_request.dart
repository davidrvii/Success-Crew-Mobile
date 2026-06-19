/// File: lib/features/leave/data/models/leave_request.dart
/// Generated Documentation for leave_request.dart

/// Class representing `LeaveRequest`.
/// Auto-generated class documentation.
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
      map['leave_start'] = startDate;
      map['start_date'] = startDate;
      map['startDate'] = startDate;
    }

    if (endDate != null && endDate!.isNotEmpty) {
      map['leave_end'] = endDate;
      map['end_date'] = endDate;
      map['endDate'] = endDate;
    }

    if (reason != null && reason!.isNotEmpty) {
      map['leave_desc'] = reason;
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
