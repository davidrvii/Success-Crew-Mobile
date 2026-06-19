/// File: lib/features/home/domain/entities/home_attendance_summary.dart
/// Generated Documentation for home_attendance_summary.dart

/// Class representing `HomeAttendanceSummary`.
/// Auto-generated class documentation.
class HomeAttendanceSummary {
  final HomeTodayAbsence today;
  final int presentCount;
  final int lateCount;
  final int leaveCount;
  final int overtimeCount;
  final int outOfOfficeCount;

  const HomeAttendanceSummary({
    required this.today,
    required this.presentCount,
    required this.lateCount,
    required this.leaveCount,
    required this.overtimeCount,
    required this.outOfOfficeCount,
  });
}

abstract class HomeTodayAbsence {
  const HomeTodayAbsence();

  bool get hasCheckedIn;

  factory HomeTodayAbsence.notCheckedIn() =>
      const HomeTodayAbsenceNotCheckedIn();

  factory HomeTodayAbsence.checkedIn({
    required int attendanceId,
    required DateTime? checkInAt,
    required DateTime? checkOutAt,
    required String? status,
  }) {
    return HomeTodayAbsenceCheckedIn(
      attendanceId: attendanceId,
      checkInAt: checkInAt,
      checkOutAt: checkOutAt,
      status: status,
    );
  }
}

/// Class representing `HomeTodayAbsenceNotCheckedIn`.
/// Auto-generated class documentation.
class HomeTodayAbsenceNotCheckedIn extends HomeTodayAbsence {
  const HomeTodayAbsenceNotCheckedIn();

  @override
  /// Getter for `hasCheckedIn` returning `bool`.
  bool get hasCheckedIn => false;
}

/// Class representing `HomeTodayAbsenceCheckedIn`.
/// Auto-generated class documentation.
class HomeTodayAbsenceCheckedIn extends HomeTodayAbsence {
  final int attendanceId;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;
  final String? status;

  const HomeTodayAbsenceCheckedIn({
    required this.attendanceId,
    required this.checkInAt,
    required this.checkOutAt,
    required this.status,
  });

  @override
  /// Getter for `hasCheckedIn` returning `bool`.
  bool get hasCheckedIn => true;

  /// Getter for `hasCheckedOut` returning `bool`.
  bool get hasCheckedOut => checkOutAt != null;
}
