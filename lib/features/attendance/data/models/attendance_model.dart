class AttendanceDto {
  final int id;
  final int userId;

  final DateTime? attendanceDate;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;

  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? overtime;

  const AttendanceDto({
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

  factory AttendanceDto.fromJson(Map<String, dynamic> json) {
    return AttendanceDto(
      id: _readInt(json, ['attendance_id', 'id', 'attendanceId']) ?? 0,
      userId: _readInt(json, ['user_id', 'userId']) ?? 0,
      attendanceDate: _readDate(json, [
        'attendance_date',
        'attendanceDate',
        'date',
      ]),
      checkInAt: _readDate(json, ['attendance_in', 'check_in', 'check_in_at', 'checkInAt']),
      checkOutAt: _readDate(json, ['attendance_out', 'check_out', 'check_out_at', 'checkOutAt']),
      status: _readString(json, ['attendance_status', 'status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
      overtime: _readInt(json, ['overtime', 'overtime_hours', 'overtimeHours']) ?? _calculateOvertimesHours(json['overtimes']),
    );
  }
}

/// List Response

class AttendanceListResponse {
  final int statusCode;
  final String message;
  final List<AttendanceDto> items;
  final int present;
  final int late;
  final int leave;
  final int overtime;

  const AttendanceListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
    required this.present,
    required this.late,
    required this.leave,
    required this.overtime,
  });

  factory AttendanceListResponse.fromJson(Map<String, dynamic> json) {
    final list = _readList(json, [
      'crewAttendanceHistory',
      'attendance',
      'attendances',
      'attendanceHistory',
      'crewAttendance',
      'items',
      'data',
    ]);

    final extracted = <dynamic>[];
    if (list is List) {
      extracted.addAll(list);
    } else if (list is Map<String, dynamic>) {
      final nested = _readList(list, ['attendances', 'attendance', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    int leaveCount = 0;
    final history = json['crewAttendanceHistory'];
    if (history is Map<String, dynamic>) {
      final leaves = history['leaves'];
      if (leaves is List) {
        final now = DateTime.now();
        final currentYear = now.year;
        int count = 0;
        for (final l in leaves) {
          if (l is Map<String, dynamic>) {
            final rawDate = l['leave_date'] ?? l['leaveDate'] ?? l['date'];
            if (rawDate is String) {
              final parsed = DateTime.tryParse(rawDate);
              if (parsed != null && parsed.toLocal().year == currentYear) {
                count++;
              }
            }
          }
        }
        leaveCount = count;
      }
    }

    return AttendanceListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(AttendanceDto.fromJson)
          .toList(),
      present: (json['present'] as num?)?.toInt() ?? 0,
      late: (json['late'] as num?)?.toInt() ?? 0,
      leave: leaveCount,
      overtime: (json['overtime'] as num?)?.toInt() ?? 0,
    );
  }
}

/// Detail Response

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

    AttendanceDto? parsed;
    if (obj != null) parsed = AttendanceDto.fromJson(obj);

    return AttendanceDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: parsed,
    );
  }
}

/// Check-in Response

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
      'attendanceIn',
      'newAttendance',
      'attendance',
      'createdAttendance',
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

/// Check-out Response

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

/// Delete Response

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
        _readInt(_readMap(json, ['data', 'result']) ?? const {}, [
          'attendanceId',
          'id',
        ]);

    return DeleteAttendanceResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      attendanceId: id,
    );
  }
}

/// Helpers (private-ish)

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

dynamic _readList(Map<String, dynamic> json, List<String> keys) {
  for (final k in keys) {
    final v = json[k];
    if (v != null) return v;
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
