class HomeAttendanceSummary {
  final HomeTodayAbsence today;
  final int hadirCount;
  final int telatCount;
  final int cutiCount;
  final int lemburCount;

  const HomeAttendanceSummary({
    required this.today,
    required this.hadirCount,
    required this.telatCount,
    required this.cutiCount,
    required this.lemburCount,
  });
}

/// Status absensi hari ini:
/// - Belum check-in => NotCheckedIn
/// - Sudah check-in => CheckedIn
sealed class HomeTodayAbsence {
  const HomeTodayAbsence();

  bool get hasCheckedIn;

  factory HomeTodayAbsence.notCheckedIn() = HomeTodayAbsenceNotCheckedIn;

  factory HomeTodayAbsence.checkedIn({
    required int attendanceId,
    required DateTime? checkInAt,
    required DateTime? checkOutAt,
    required String? status,
  }) = HomeTodayAbsenceCheckedIn;
}

class HomeTodayAbsenceNotCheckedIn extends HomeTodayAbsence {
  const HomeTodayAbsenceNotCheckedIn();

  @override
  bool get hasCheckedIn => false;
}

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
  bool get hasCheckedIn => true;

  bool get hasCheckedOut => checkOutAt != null;
}
