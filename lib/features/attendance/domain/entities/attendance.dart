class Attendance {
  final int id;
  final int userId;

  final DateTime? attendanceDate;

  final DateTime? checkInAt;
  final DateTime? checkOutAt;

  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Attendance({
    required this.id,
    required this.userId,
    required this.attendanceDate,
    required this.checkInAt,
    required this.checkOutAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get hasCheckedIn => checkInAt != null;
  bool get hasCheckedOut => checkOutAt != null;

  String get displayStatus {
    final s = (status ?? '').trim();
    return s.isEmpty ? '-' : s;
  }
}
