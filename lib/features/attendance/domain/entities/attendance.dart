/// File: lib/features/attendance/domain/entities/attendance.dart
/// Generated Documentation for attendance.dart

/// Class representing `Attendance`.
/// Auto-generated class documentation.
class Attendance {
  final int id;
  final int? userId;

  final DateTime? attendanceDate;

  final DateTime? checkInAt;
  final DateTime? checkOutAt;

  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? overtime;

  const Attendance({
    required this.id,
    this.userId,
    required this.attendanceDate,
    required this.checkInAt,
    required this.checkOutAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.overtime,
  });

  /// Getter for `hasCheckedIn` returning `bool`.
  bool get hasCheckedIn => checkInAt != null;
  /// Getter for `hasCheckedOut` returning `bool`.
  bool get hasCheckedOut => checkOutAt != null;

  String get displayStatus {
    final s = (status ?? '').trim();
    return s.isEmpty ? '-' : s;
  }
}

/// Basic today's attendance state — from GET /attendance/basic
/// Class representing `AttendanceBasic`.
/// Auto-generated class documentation.
class AttendanceBasic {
  final DateTime? attendanceIn;
  final DateTime? attendanceOut;

  const AttendanceBasic({this.attendanceIn, this.attendanceOut});

  /// Getter for `hasCheckedIn` returning `bool`.
  bool get hasCheckedIn => attendanceIn != null;
  /// Getter for `hasCheckedOut` returning `bool`.
  bool get hasCheckedOut => attendanceOut != null;
}

/// A single entry in the crew history list (mixed type)
/// type: "attendance" | "overtime" | "leave" | "out_of_office"
/// Class representing `CrewHistoryItem`.
/// Auto-generated class documentation.
class CrewHistoryItem {
  final int id;
  final String type;
  final DateTime? date;
  final String? status;
  final String? description;

  // For type = "attendance"
  final DateTime? attendanceIn;
  final DateTime? attendanceOut;

  // For type = "overtime"
  final DateTime? overtimeStart;
  final DateTime? overtimeEnd;

  // For type = "leave"
  final DateTime? leaveStart;
  final DateTime? leaveEnd;

  // For type = "out_of_office"
  final DateTime? outOfOfficeStart;
  final DateTime? outOfOfficeEnd;

  const CrewHistoryItem({
    required this.id,
    required this.type,
    this.date,
    this.status,
    this.description,
    this.attendanceIn,
    this.attendanceOut,
    this.overtimeStart,
    this.overtimeEnd,
    this.leaveStart,
    this.leaveEnd,
    this.outOfOfficeStart,
    this.outOfOfficeEnd,
  });

  /// Getter for `isAttendance` returning `bool`.
  bool get isAttendance => type == 'attendance';
  /// Getter for `isOvertime` returning `bool`.
  bool get isOvertime => type == 'overtime';
  /// Getter for `isLeave` returning `bool`.
  bool get isLeave => type == 'leave';
  /// Getter for `isOutOfOffice` returning `bool`.
  bool get isOutOfOffice => type == 'out_of_office';
}

/// Full crew attendance history — from GET /attendance/crew/:userId
/// Class representing `CrewAttendanceHistory`.
/// Auto-generated class documentation.
class CrewAttendanceHistory {
  final int totalAttendance;
  final int totalLate;
  final int totalLeave;
  final int totalOvertime;
  final int totalOutOfOffice;

  /// Mixed-type chronological history
  final List<CrewHistoryItem> history;

  /// Flat attendance records only
  final List<Attendance> attendance;

  const CrewAttendanceHistory({
    required this.totalAttendance,
    required this.totalLate,
    required this.totalLeave,
    required this.totalOvertime,
    required this.totalOutOfOffice,
    required this.history,
    required this.attendance,
  });
}

/// Legacy: kept for backward compatibility with controllers expecting this shape
/// Class representing `AttendanceHistoryData`.
/// Auto-generated class documentation.
class AttendanceHistoryData {
  final List<Attendance> history;
  final int presentCount;
  final int lateCount;
  final int leaveCount;
  final int overtimeCount;
  final int outOfOfficeCount;

  const AttendanceHistoryData({
    required this.history,
    required this.presentCount,
    required this.lateCount,
    required this.leaveCount,
    required this.overtimeCount,
    required this.outOfOfficeCount,
  });
}
