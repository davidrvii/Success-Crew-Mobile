class AttendanceDto {
  final int id;
  final int userId;

  final DateTime? attendanceDate;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;

  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AttendanceDto({
    required this.id,
    required this.userId,
    required this.attendanceDate,
    required this.checkInAt,
    required this.checkOutAt,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
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
      checkInAt: _readDate(json, ['check_in', 'check_in_at', 'checkInAt']),
      checkOutAt: _readDate(json, ['check_out', 'check_out_at', 'checkOutAt']),
      status: _readString(json, ['attendance_status', 'status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
    );
  }
}

/// List Response

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
    final list = _readList(json, [
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
      final nested = _readList(list, ['attendance', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    return AttendanceListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(AttendanceDto.fromJson)
          .toList(),
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
