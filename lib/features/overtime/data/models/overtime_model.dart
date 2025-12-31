class OvertimeDto {
  final int id;
  final int userId;

  final DateTime? overtimeDate;
  final DateTime? startTime;
  final DateTime? endTime;

  final String? reason;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const OvertimeDto({
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

  factory OvertimeDto.fromJson(Map<String, dynamic> json) {
    return OvertimeDto(
      id: _readInt(json, ['overtime_id', 'id', 'overtimeId']) ?? 0,
      userId: _readInt(json, ['user_id', 'userId']) ?? 0,
      overtimeDate: _readDate(json, ['overtime_date', 'overtimeDate', 'date']),
      startTime: _readDate(json, ['start_time', 'startTime', 'start']),
      endTime: _readDate(json, ['end_time', 'endTime', 'end']),
      reason: _readString(json, ['reason', 'overtime_reason']),
      status: _readString(json, ['status', 'overtime_status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
    );
  }
}

/// LIST RESPONSE

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
    final obj = _readMap(json, ['updatedOvertime', 'overtime', 'data']);

    return UpdateOvertimeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      overtime: obj == null ? null : OvertimeDto.fromJson(obj),
    );
  }
}

/// DELETE RESPONSE

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
    }
  }
  return null;
}
