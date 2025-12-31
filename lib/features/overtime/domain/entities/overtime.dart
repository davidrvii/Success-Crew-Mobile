class Overtime {
  final int id;
  final int userId;

  final DateTime? overtimeDate;
  final DateTime? startTime;
  final DateTime? endTime;

  final String? reason;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Overtime({
    required this.id,
    required this.userId,
    required this.overtimeDate,
    required this.startTime,
    required this.endTime,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
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
