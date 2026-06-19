// ─────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────

int? _readInt(Map<String, dynamic> json, List<String> keys) {
  for (final k in keys) {
    final v = json[k];
    if (v is num) return v.toInt();
    if (v is String) return int.tryParse(v);
  }
  return null;
}

String? _readString(Map<String, dynamic> json, List<String> keys) {
  for (final k in keys) {
    final v = json[k];
    if (v is String) return v;
  }
  return null;
}

DateTime? _readDate(Map<String, dynamic> json, List<String> keys) {
  for (final k in keys) {
    final v = json[k];
    if (v is String) {
      final dt = DateTime.tryParse(v);
      if (dt != null) return dt;
    }
  }
  return null;
}

Map<String, dynamic>? _readMap(Map<String, dynamic> json, List<String> keys) {
  for (final k in keys) {
    final v = json[k];
    if (v is Map<String, dynamic>) return v;
  }
  return null;
}

List<Map<String, dynamic>> _readListMap(
  Map<String, dynamic> json,
  List<String> keys,
) {
  for (final k in keys) {
    final v = json[k];
    if (v is List) return v.whereType<Map<String, dynamic>>().toList();
  }
  return const [];
}

int _calculateOvertimesHours(dynamic overtimes) {
  if (overtimes is! List) return 0;
  int totalHours = 0;
  for (final o in overtimes) {
    if (o is Map<String, dynamic>) {
      final startStr = o['overtime_start'] ?? o['overtimeStart'];
      final endStr = o['overtime_end'] ?? o['overtimeEnd'];
      if (startStr is String && endStr is String) {
        final start = DateTime.tryParse(startStr);
        final end = DateTime.tryParse(endStr);
        if (start != null && end != null) {
          totalHours += end.difference(start).inHours;
        }
      }
    }
  }
  return totalHours;
}

// ─────────────────────────────────────────────
// DTO: Single Attendance record
// Maps from both /attendance/all and /attendance/crew/:userId `attendance[]`
// ─────────────────────────────────────────────

class AttendanceDto {
  final int id;
  final int? userId;

  final DateTime? attendanceDate;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;

  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? overtime;

  const AttendanceDto({
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

  factory AttendanceDto.fromJson(Map<String, dynamic> json) {
    return AttendanceDto(
      id: _readInt(json, ['attendance_id', 'id', 'attendanceId']) ?? 0,
      userId: _readInt(json, ['user_id', 'userId']),
      attendanceDate: _readDate(json, [
        'attendance_date',
        'attendanceDate',
        'date',
      ]),
      checkInAt: _readDate(json, [
        'attendance_in',
        'check_in',
        'check_in_at',
        'checkInAt',
      ]),
      checkOutAt: _readDate(json, [
        'attendance_out',
        'check_out',
        'check_out_at',
        'checkOutAt',
      ]),
      status: _readString(json, ['attendance_status', 'status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
      overtime:
          _readInt(json, ['overtime', 'overtime_hours', 'overtimeHours']) ??
          _calculateOvertimesHours(json['overtimes']),
    );
  }
}

// ─────────────────────────────────────────────
// DTO: Crew History item (one entry in `history[]`)
// Covers type: attendance | overtime | leave | out_of_office
// ─────────────────────────────────────────────

class CrewHistoryItemDto {
  final int id;
  final String type; // "attendance", "overtime", "leave", "out_of_office"
  final DateTime? date;
  final String? status;
  final String? description;
  final Map<String, dynamic> details;

  const CrewHistoryItemDto({
    required this.id,
    required this.type,
    this.date,
    this.status,
    this.description,
    required this.details,
  });

  factory CrewHistoryItemDto.fromJson(Map<String, dynamic> json) {
    final detailsRaw = json['details'];
    final details = detailsRaw is Map<String, dynamic> ? detailsRaw : <String, dynamic>{};

    return CrewHistoryItemDto(
      id: _readInt(json, ['id']) ?? 0,
      type: (json['type'] as String?) ?? 'attendance',
      date: _readDate(json, ['date']),
      status: json['status'] as String?,
      description: json['description'] as String?,
      details: details,
    );
  }

  // Convenience getters for attendance type
  DateTime? get attendanceIn => details['attendance_in'] is String
      ? DateTime.tryParse(details['attendance_in'] as String)
      : null;
  DateTime? get attendanceOut => details['attendance_out'] is String
      ? DateTime.tryParse(details['attendance_out'] as String)
      : null;

  // Convenience getters for overtime type
  DateTime? get overtimeStart => details['overtime_start'] is String
      ? DateTime.tryParse(details['overtime_start'] as String)
      : null;
  DateTime? get overtimeEnd => details['overtime_end'] is String
      ? DateTime.tryParse(details['overtime_end'] as String)
      : null;

  // Convenience getters for leave type
  DateTime? get leaveStart {
    final s = details['leave_start'] ?? details['leaveStart'] ?? details['start_date'] ?? details['startDate'];
    return s is String ? DateTime.tryParse(s) : null;
  }
  DateTime? get leaveEnd {
    final s = details['leave_end'] ?? details['leaveEnd'] ?? details['end_date'] ?? details['endDate'];
    return s is String ? DateTime.tryParse(s) : null;
  }

  // Convenience getters for out of office type
  DateTime? get outOfOfficeStart {
    final s = details['out_of_office_start'] ?? details['outofoffice_start'] ?? details['outOfOfficeStart'] ?? details['outofofficeStart'];
    return s is String ? DateTime.tryParse(s) : null;
  }
  DateTime? get outOfOfficeEnd {
    final s = details['out_of_office_end'] ?? details['outofoffice_end'] ?? details['outOfOfficeEnd'] ?? details['outofofficeEnd'];
    return s is String ? DateTime.tryParse(s) : null;
  }
}

// ─────────────────────────────────────────────
// DTO: Crew Attendance History wrapper
// from GET /attendance/crew/:userId → crewAttendanceHistory
// ─────────────────────────────────────────────

class CrewAttendanceHistoryDto {
  final int totalAttendance;
  final int totalLate;
  final int totalLeave;
  final int totalOvertime;
  final int totalOutOfOffice;

  final List<CrewHistoryItemDto> history;
  final List<AttendanceDto> attendance;

  const CrewAttendanceHistoryDto({
    required this.totalAttendance,
    required this.totalLate,
    required this.totalLeave,
    required this.totalOvertime,
    required this.totalOutOfOffice,
    required this.history,
    required this.attendance,
  });

  factory CrewAttendanceHistoryDto.fromJson(Map<String, dynamic> json) {
    final historyRaw = _readListMap(json, ['history']);
    final attendanceRaw = _readListMap(json, ['attendance']);

    return CrewAttendanceHistoryDto(
      totalAttendance:
          _readInt(json, ['total_attendance', 'totalAttendance']) ?? 0,
      totalLate: _readInt(json, ['total_late', 'totalLate']) ?? 0,
      totalLeave: _readInt(json, ['total_leave', 'totalLeave']) ?? 0,
      totalOvertime: _readInt(json, ['total_overtime', 'totalOvertime']) ?? 0,
      totalOutOfOffice:
          _readInt(json, ['total_out_of_office', 'totalOutOfOffice']) ?? 0,
      history: historyRaw.map(CrewHistoryItemDto.fromJson).toList(),
      attendance: attendanceRaw.map(AttendanceDto.fromJson).toList(),
    );
  }
}

// ─────────────────────────────────────────────
// DTO: Attendance Basic
// from GET /attendance/basic → attendanceBasic
// ─────────────────────────────────────────────

class AttendanceBasicDto {
  final DateTime? attendanceIn;
  final DateTime? attendanceOut;

  const AttendanceBasicDto({this.attendanceIn, this.attendanceOut});

  factory AttendanceBasicDto.fromJson(Map<String, dynamic> json) {
    return AttendanceBasicDto(
      attendanceIn: _readDate(json, ['attendance_in', 'attendanceIn']),
      attendanceOut: _readDate(json, ['attendance_out', 'attendanceOut']),
    );
  }
}

// ─────────────────────────────────────────────
// RESPONSES
// ─────────────────────────────────────────────

/// GET /attendance/all
class AttendanceListResponse {
  final int statusCode;
  final String message;
  final List<AttendanceDto> items;

  const AttendanceListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) {
    final list = _readListMap(json, [
      'attendance',
      'attendances',
      'items',
      'data',
    ]);

    return AttendanceListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: list.map(AttendanceDto.fromJson).toList(),
    );
  }
}

/// GET /attendance/crew/:userId
class CrewAttendanceResponse {
  final int statusCode;
  final String message;
  final CrewAttendanceHistoryDto? data;

  const CrewAttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory CrewAttendanceResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readMap(json, ['crewAttendanceHistory', 'data']);
    return CrewAttendanceResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      data: raw == null ? null : CrewAttendanceHistoryDto.fromJson(raw),
    );
  }
}

/// GET /attendance/basic
class AttendanceBasicResponse {
  final int statusCode;
  final String message;
  final AttendanceBasicDto? basic;

  const AttendanceBasicResponse({
    required this.statusCode,
    required this.message,
    required this.basic,
  });

  factory AttendanceBasicResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readMap(json, ['attendanceBasic', 'basic', 'data']);
    return AttendanceBasicResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      basic: raw == null ? null : AttendanceBasicDto.fromJson(raw),
    );
  }
}

/// GET /attendance/detail/:id
class AttendanceDetailResponse {
  final int statusCode;
  final String message;
  final AttendanceDto? detail;

  const AttendanceDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory AttendanceDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'attendanceDetail',
      'attendance',
      'detail',
      'data',
    ]);

    return AttendanceDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : AttendanceDto.fromJson(obj),
    );
  }
}

/// POST /attendance/add
class AddAttendanceResponse {
  final int statusCode;
  final String message;
  final AttendanceDto? attendance;

  const AddAttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.attendance,
  });

  factory AddAttendanceResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'attendanceAdded',
      'newAttendance',
      'attendance',
      'data',
    ]);

    return AddAttendanceResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      attendance: obj == null ? null : AttendanceDto.fromJson(obj),
    );
  }
}

/// PATCH /attendance/checkin → response key: `checkin`
class CheckInResponse {
  final int statusCode;
  final String message;
  final AttendanceDto? attendance;

  const CheckInResponse({
    required this.statusCode,
    required this.message,
    required this.attendance,
  });

  factory CheckInResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'checkin',
      'attendanceIn',
      'newAttendance',
      'attendance',
      'checkInResult',
      'data',
    ]);

    return CheckInResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      attendance: obj == null ? null : AttendanceDto.fromJson(obj),
    );
  }
}

/// PATCH /attendance/checkout → response key: `checkout`
class CheckOutResponse {
  final int statusCode;
  final String message;
  final AttendanceDto? attendance;

  const CheckOutResponse({
    required this.statusCode,
    required this.message,
    required this.attendance,
  });

  factory CheckOutResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'checkout',
      'attendanceOut',
      'updatedAttendance',
      'attendance',
      'checkOutResult',
      'data',
    ]);

    return CheckOutResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      attendance: obj == null ? null : AttendanceDto.fromJson(obj),
    );
  }
}

/// PUT /attendance/update/:attendanceId
class UpdateAttendanceResponse {
  final int statusCode;
  final String message;
  final AttendanceDto? attendance;

  const UpdateAttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.attendance,
  });

  factory UpdateAttendanceResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'attendanceUpdated',
      'updatedAttendance',
      'attendance',
      'data',
    ]);

    return UpdateAttendanceResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      attendance: obj == null ? null : AttendanceDto.fromJson(obj),
    );
  }
}

/// DELETE /attendance/delete/:attendanceId
class DeleteAttendanceResponse {
  final int statusCode;
  final String message;
  final int? attendanceId;

  const DeleteAttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.attendanceId,
  });

  factory DeleteAttendanceResponse.fromJson(Map<String, dynamic> json) {
    final id =
        _readInt(json, ['attendanceId', 'attendance_id', 'id']) ??
        _readInt(
          _readMap(json, ['data', 'result']) ?? const {},
          ['attendanceId', 'id'],
        );

    return DeleteAttendanceResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      attendanceId: id,
    );
  }
}
