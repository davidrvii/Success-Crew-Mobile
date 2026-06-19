/// File: lib/features/leave/data/models/leave_model.dart
/// Generated Documentation for leave_model.dart

/// Class representing `LeaveDto`.
/// Auto-generated class documentation.
class LeaveDto {
  final int id;
  final int userId;

  final String? leaveType;
  final DateTime? startDate;
  final DateTime? endDate;

  final String? reason;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final String? userName;

  const LeaveDto({
    required this.id,
    required this.userId,
    required this.leaveType,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.userName,
  });

  factory LeaveDto.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'] is Map<String, dynamic> ? json['user'] as Map<String, dynamic> : null;
    final uName = userMap?['user_name'] as String? ?? json['user_name'] as String? ?? json['userName'] as String?;

    return LeaveDto(
      id: _readInt(json, ['leave_id', 'id', 'leaveId']) ?? 0,
      userId: _readInt(json, ['user_id', 'userId']) ?? 0,
      leaveType: _readString(json, ['leave_type', 'leaveType', 'type']),
      startDate: _readDate(json, ['start_date', 'startDate']),
      endDate: _readDate(json, ['end_date', 'endDate']),
      reason: _readString(json, ['reason', 'leave_reason']),
      status: _readString(json, ['status', 'leave_status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
      userName: uName,
    );
  }
}

/// LIST RESPONSE

/// Class representing `LeaveListResponse`.
/// Auto-generated class documentation.
class LeaveListResponse {
  final int statusCode;
  final String message;
  final List<LeaveDto> items;

  const LeaveListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory LeaveListResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readAny(json, [
      'leave',
      'leaves',
      'leaveList',
      'leaveHistory',
      'crewLeave',
      'items',
      'data',
    ]);

    final extracted = <dynamic>[];
    if (raw is List) {
      extracted.addAll(raw);
    } else if (raw is Map<String, dynamic>) {
      final nested = _readAny(raw, ['leave', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    return LeaveListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(LeaveDto.fromJson)
          .toList(),
    );
  }
}

/// DETAIL RESPONSE

/// Class representing `LeaveDetailResponse`.
/// Auto-generated class documentation.
class LeaveDetailResponse {
  final int statusCode;
  final String message;
  final LeaveDto? detail;

  const LeaveDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory LeaveDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, ['leaveDetail', 'leave', 'detail', 'data']);

    return LeaveDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : LeaveDto.fromJson(obj),
    );
  }
}

/// CREATE RESPONSE

/// Class representing `CreateLeaveResponse`.
/// Auto-generated class documentation.
class CreateLeaveResponse {
  final int statusCode;
  final String message;
  final LeaveDto? leave;

  const CreateLeaveResponse({
    required this.statusCode,
    required this.message,
    required this.leave,
  });

  factory CreateLeaveResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'newLeave',
      'createdLeave',
      'leave',
      'leaveCreated',
      'data',
    ]);

    return CreateLeaveResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      leave: obj == null ? null : LeaveDto.fromJson(obj),
    );
  }
}

/// UPDATE RESPONSE

/// Class representing `UpdateLeaveResponse`.
/// Auto-generated class documentation.
class UpdateLeaveResponse {
  final int statusCode;
  final String message;
  final LeaveDto? leave;

  const UpdateLeaveResponse({
    required this.statusCode,
    required this.message,
    required this.leave,
  });

  factory UpdateLeaveResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, ['updatedLeave', 'leave', 'data']);

    return UpdateLeaveResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      leave: obj == null ? null : LeaveDto.fromJson(obj),
    );
  }
}

/// DELETE RESPONSE

/// Class representing `DeleteLeaveResponse`.
/// Auto-generated class documentation.
class DeleteLeaveResponse {
  final int statusCode;
  final String message;
  final int? leaveId;

  const DeleteLeaveResponse({
    required this.statusCode,
    required this.message,
    required this.leaveId,
  });

  factory DeleteLeaveResponse.fromJson(Map<String, dynamic> json) {
    final id =
        _readInt(json, ['leaveId', 'leave_id', 'id']) ??
        _readInt(_readMap(json, ['data', 'result']) ?? const {}, [
          'leaveId',
          'id',
        ]);

    return DeleteLeaveResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      leaveId: id,
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
