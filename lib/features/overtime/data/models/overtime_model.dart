/// File: lib/features/overtime/data/models/overtime_model.dart
/// Generated Documentation for overtime_model.dart

/// Class representing `OvertimeDto`.
/// Auto-generated class documentation.
class OvertimeDto {
  final int id;
  final int userId;
  final int? attendanceId;

  final DateTime? overtimeDate;
  final DateTime? startTime;
  final DateTime? endTime;

  final String? reason;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;

  const OvertimeDto({
    required this.id,
    required this.userId,
    this.attendanceId,
    required this.overtimeDate,
    required this.startTime,
    required this.endTime,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.userName,
  });

  factory OvertimeDto.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'] is Map<String, dynamic> ? json['user'] as Map<String, dynamic> : null;
    final uName = userMap?['user_name'] as String? ?? json['user_name'] as String? ?? json['userName'] as String? ?? json['Crew'] as String?;

    return OvertimeDto(
      id: _readInt(json, ['overtime_id', 'id', 'overtimeId']) ?? 0,
      userId: _readInt(json, ['user_id', 'userId']) ?? 0,
      attendanceId: _readInt(json, ['attendance_id', 'attendanceId']),
      overtimeDate: _readDate(json, ['overtime_date', 'overtimeDate', 'date']),
      startTime: _readDate(json, ['overtime_start', 'start_time', 'startTime', 'start']),
      endTime: _readDate(json, ['overtime_end', 'end_time', 'endTime', 'end']),
      reason: _readString(json, ['overtime_desc', 'reason', 'overtime_reason']),
      status: _readString(json, ['overtime_status', 'status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
      userName: uName,
    );
  }
}

/// LIST RESPONSE

/// Class representing `OvertimeListResponse`.
/// Auto-generated class documentation.
class OvertimeListResponse {
  final int statusCode;
  final String message;
  final List<OvertimeDto> items;

  const OvertimeListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory OvertimeListResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readAny(json, [
      'overtime',
      'overtimes',
      'crewOvertimes',
      'overtimeList',
      'overtimeHistory',
      'crewOvertime',
      'items',
      'data',
    ]);

    final extracted = <dynamic>[];
    if (raw is List) {
      extracted.addAll(raw);
    } else if (raw is Map<String, dynamic>) {
      final nested = _readAny(raw, ['overtime', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    return OvertimeListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(OvertimeDto.fromJson)
          .toList(),
    );
  }
}

/// DETAIL RESPONSE

/// Class representing `OvertimeDetailResponse`.
/// Auto-generated class documentation.
class OvertimeDetailResponse {
  final int statusCode;
  final String message;
  final OvertimeDto? detail;

  const OvertimeDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory OvertimeDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'overtimeDetail',
      'overtime',
      'detail',
      'data',
    ]);

    return OvertimeDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : OvertimeDto.fromJson(obj),
    );
  }
}

/// CREATE RESPONSE

/// Class representing `CreateOvertimeResponse`.
/// Auto-generated class documentation.
class CreateOvertimeResponse {
  final int statusCode;
  final String message;
  final OvertimeDto? overtime;

  const CreateOvertimeResponse({
    required this.statusCode,
    required this.message,
    required this.overtime,
  });

  factory CreateOvertimeResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'overtimeCreated',
      'newOvertime',
      'createdOvertime',
      'overtime',
      'data',
    ]);

    return CreateOvertimeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      overtime: obj == null ? null : OvertimeDto.fromJson(obj),
    );
  }
}

/// UPDATE RESPONSE

/// Class representing `UpdateOvertimeResponse`.
/// Auto-generated class documentation.
class UpdateOvertimeResponse {
  final int statusCode;
  final String message;
  final OvertimeDto? overtime;

  const UpdateOvertimeResponse({
    required this.statusCode,
    required this.message,
    required this.overtime,
  });

  factory UpdateOvertimeResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'overtimeUpdated',
      'updatedOvertime',
      'overtime',
      'data',
    ]);

    return UpdateOvertimeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      overtime: obj == null ? null : OvertimeDto.fromJson(obj),
    );
  }
}

/// DELETE RESPONSE

/// Class representing `DeleteOvertimeResponse`.
/// Auto-generated class documentation.
class DeleteOvertimeResponse {
  final int statusCode;
  final String message;
  final int? overtimeId;

  const DeleteOvertimeResponse({
    required this.statusCode,
    required this.message,
    required this.overtimeId,
  });

  factory DeleteOvertimeResponse.fromJson(Map<String, dynamic> json) {
    final id =
        _readInt(json, ['overtimeId', 'overtime_id', 'id']) ??
        _readInt(_readMap(json, ['data', 'result']) ?? const {}, [
          'overtimeId',
          'id',
        ]);

    return DeleteOvertimeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      overtimeId: id,
    );
  }
}

/// BASIC DTO AND RESPONSES

/// Class representing `OvertimeBasicDto`.
/// Auto-generated class documentation.
class OvertimeBasicDto {
  final int id;
  final String status;
  final int totalUnapproved;

  const OvertimeBasicDto({
    required this.id,
    required this.status,
    required this.totalUnapproved,
  });

  factory OvertimeBasicDto.fromJson(Map<String, dynamic> json) {
    return OvertimeBasicDto(
      id: _readInt(json, ['overtime_id', 'id', 'overtimeId']) ?? 0,
      status: _readString(json, ['overtime_status', 'status']) ?? '',
      totalUnapproved: _readInt(json, ['total_unapproved', 'totalUnapproved']) ?? 0,
    );
  }
}

/// Class representing `OvertimeBasicListResponse`.
/// Auto-generated class documentation.
class OvertimeBasicListResponse {
  final int statusCode;
  final String message;
  final List<OvertimeDto> items;
  final int totalUnapproved;

  const OvertimeBasicListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
    required this.totalUnapproved,
  });

  factory OvertimeBasicListResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readAny(json, [
      'overtime',
      'overtimes',
      'crewOvertimes',
      'overtimeList',
      'overtimeHistory',
      'crewOvertime',
      'items',
      'data',
    ]);

    final extracted = <dynamic>[];
    if (raw is List) {
      extracted.addAll(raw);
    } else if (raw is Map<String, dynamic>) {
      final nested = _readAny(raw, ['overtime', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    return OvertimeBasicListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(OvertimeDto.fromJson)
          .toList(),
      totalUnapproved: _readInt(json, ['total_unapproved', 'totalUnapproved']) ?? 0,
    );
  }
}

/// Class representing `OvertimeBasicDetailResponse`.
/// Auto-generated class documentation.
class OvertimeBasicDetailResponse {
  final int statusCode;
  final String message;
  final OvertimeBasicDto? detail;

  const OvertimeBasicDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory OvertimeBasicDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'overtimeBasic',
      'basic',
      'detail',
      'data',
    ]);

    return OvertimeBasicDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : OvertimeBasicDto.fromJson(obj),
    );
  }
}

/// Helpers

dynamic _readAny(Map<String, dynamic> json, List<String> keys) {
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
      // Try parsing as time only (e.g. "08:00" or "08:00:00")
      if (RegExp(r'^\d{2}:\d{2}(:\d{2})?$').hasMatch(v)) {
        final dummyDt = DateTime.tryParse('1970-01-01T$v');
        if (dummyDt != null) return dummyDt;
        final dummyDt2 = DateTime.tryParse('1970-01-01 $v');
        if (dummyDt2 != null) return dummyDt2;
      }
    }
  }
  return null;
}
