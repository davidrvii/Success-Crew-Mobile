class Attendance {
  final int id;
  final int userId;

  final DateTime? attendanceDate;

  final DateTime? checkInAt;
  final DateTime? checkOutAt;

  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? overtime;

  const Attendance({
    required this.id,
    required this.userId,
    required this.attendanceDate,
    required this.checkInAt,
    required this.checkOutAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.overtime,
  });

  bool get hasCheckedIn => checkInAt != null;
  bool get hasCheckedOut => checkOutAt != null;

  String get displayStatus {
    final s = (status ?? '').trim();
    return s.isEmpty ? '-' : s;
  }
}

class AttendanceHistoryData {
  final List<Attendance> history;
  final int presentCount;
  final int lateCount;
  final int leaveCount;
  final int overtimeCount;

  const AttendanceHistoryData({
    required this.history,
    required this.presentCount,
    required this.lateCount,
    required this.leaveCount,
    required this.overtimeCount,
  });
}
