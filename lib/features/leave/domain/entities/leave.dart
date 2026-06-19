/// File: lib/features/leave/domain/entities/leave.dart
/// Generated Documentation for leave.dart

/// Class representing `Leave`.
/// Auto-generated class documentation.
class Leave {
  final int id;
  final int userId;

  final String? leaveType;
  final DateTime? startDate;
  final DateTime? endDate;

  final String? reason;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;

  const Leave({
    required this.id,
    required this.userId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.userName,
  });

  bool get isPending {
    final s = (status ?? '').toLowerCase().trim();
    return s.contains('pending') ||
        s.contains('wait') ||
        s.contains('waiting') ||
        s.contains('process') ||
        s.contains('requested');
  }
}
