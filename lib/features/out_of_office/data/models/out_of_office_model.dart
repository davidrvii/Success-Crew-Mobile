/// File: lib/features/out_of_office/data/models/out_of_office_model.dart
/// Generated Documentation for out_of_office_model.dart

/// Class representing `OutOfOfficeDto`.
/// Auto-generated class documentation.
class OutOfOfficeDto {
  final int id;
  final int userId;

  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;

  const OutOfOfficeDto({
    required this.id,
    required this.userId,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.userName,
  });

  factory OutOfOfficeDto.fromJson(Map<String, dynamic> json) {
    final userMap = json['user'] is Map<String, dynamic> ? json['user'] as Map<String, dynamic> : null;
    final uName = userMap?['user_name'] as String? ?? json['user_name'] as String? ?? json['userName'] as String?;

    final startVal = _readDate(json, ['outofoffice_start', 'out_of_office_start', 'outofoffice_date', 'out_of_office_date', 'date']);
    final endVal = _readDate(json, ['outofoffice_end', 'out_of_office_end', 'outofoffice_date', 'out_of_office_date', 'date']);

    return OutOfOfficeDto(
      id: _readInt(json, ['outofoffice_id', 'out_of_office_id', 'id', 'outofofficeId']) ?? 0,
      userId: _readInt(json, ['user_id', 'userId']) ?? 0,
      description: _readString(json, ['outofoffice_desc', 'out_of_office_desc', 'description', 'desc']),
      startDate: startVal,
      endDate: endVal,
      status: _readString(json, ['outofoffice_status', 'out_of_office_status', 'status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
      userName: uName,
    );
  }
}

/// LIST RESPONSE

/// Class representing `OutOfOfficeListResponse`.
/// Auto-generated class documentation.
class OutOfOfficeListResponse {
  final int statusCode;
  final String message;
  final List<OutOfOfficeDto> items;

  const OutOfOfficeListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory OutOfOfficeListResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readAny(json, [
      'outOfOffices',
      'crewOutOfOffices',
      'outofoffice',
      'outofoffices',
      'items',
      'data',
    ]);

    final extracted = <dynamic>[];
    if (raw is List) {
      extracted.addAll(raw);
    } else if (raw is Map<String, dynamic>) {
      final nested = _readAny(raw, ['outOfOffices', 'crewOutOfOffices', 'outofoffice', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    return OutOfOfficeListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(OutOfOfficeDto.fromJson)
          .toList(),
    );
  }
}

/// DETAIL RESPONSE

/// Class representing `OutOfOfficeDetailResponse`.
/// Auto-generated class documentation.
class OutOfOfficeDetailResponse {
  final int statusCode;
  final String message;
  final OutOfOfficeDto? detail;

  const OutOfOfficeDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory OutOfOfficeDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'outOfOfficeDetail',
      'outofoffice',
      'detail',
      'data',
    ]);

    return OutOfOfficeDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : OutOfOfficeDto.fromJson(obj),
    );
  }
}

/// CREATE RESPONSE

/// Class representing `CreateOutOfOfficeResponse`.
/// Auto-generated class documentation.
class CreateOutOfOfficeResponse {
  final int statusCode;
  final String message;
  final OutOfOfficeDto? outOfOffice;

  const CreateOutOfOfficeResponse({
    required this.statusCode,
    required this.message,
    required this.outOfOffice,
  });

  factory CreateOutOfOfficeResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'outOfOfficeCreated',
      'outofofficeCreated',
      'newOutOfOffice',
      'createdOutOfOffice',
      'outofoffice',
      'data',
    ]);

    return CreateOutOfOfficeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      outOfOffice: obj == null ? null : OutOfOfficeDto.fromJson(obj),
    );
  }
}

/// UPDATE RESPONSE

/// Class representing `UpdateOutOfOfficeResponse`.
/// Auto-generated class documentation.
class UpdateOutOfOfficeResponse {
  final int statusCode;
  final String message;
  final OutOfOfficeDto? outOfOffice;

  const UpdateOutOfOfficeResponse({
    required this.statusCode,
    required this.message,
    required this.outOfOffice,
  });

  factory UpdateOutOfOfficeResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'outOfOfficeUpdated',
      'outofofficeUpdated',
      'updatedOutOfOffice',
      'outofoffice',
      'data',
    ]);

    return UpdateOutOfOfficeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      outOfOffice: obj == null ? null : OutOfOfficeDto.fromJson(obj),
    );
  }
}

/// DELETE RESPONSE

/// Class representing `DeleteOutOfOfficeResponse`.
/// Auto-generated class documentation.
class DeleteOutOfOfficeResponse {
  final int statusCode;
  final String message;
  final int? outOfOfficeId;

  const DeleteOutOfOfficeResponse({
    required this.statusCode,
    required this.message,
    required this.outOfOfficeId,
  });

  factory DeleteOutOfOfficeResponse.fromJson(Map<String, dynamic> json) {
    final id =
        _readInt(json, ['outOfOfficeId', 'outofoffice_id', 'out_of_office_id', 'id']) ??
        _readInt(_readMap(json, ['data', 'result']) ?? const {}, [
          'outOfOfficeId',
          'id',
        ]);

    return DeleteOutOfOfficeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      outOfOfficeId: id,
    );
  }
}

/// BASIC DTO AND RESPONSES

/// Class representing `OutOfOfficeBasicDto`.
/// Auto-generated class documentation.
class OutOfOfficeBasicDto {
  final int id;
  final String status;
  final int totalUnapproved;

  const OutOfOfficeBasicDto({
    required this.id,
    required this.status,
    required this.totalUnapproved,
  });

  factory OutOfOfficeBasicDto.fromJson(Map<String, dynamic> json) {
    return OutOfOfficeBasicDto(
      id: _readInt(json, ['outofoffice_id', 'out_of_office_id', 'id']) ?? 0,
      status: _readString(json, ['outofoffice_status', 'out_of_office_status', 'status']) ?? '',
      totalUnapproved: _readInt(json, ['total_unapproved', 'totalUnapproved']) ?? 0,
    );
  }
}

/// Class representing `OutOfOfficeBasicListResponse`.
/// Auto-generated class documentation.
class OutOfOfficeBasicListResponse {
  final int statusCode;
  final String message;
  final List<OutOfOfficeDto> items;
  final int totalUnapproved;

  const OutOfOfficeBasicListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
    required this.totalUnapproved,
  });

  factory OutOfOfficeBasicListResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readAny(json, [
      'outOfOffices',
      'crewOutOfOffices',
      'outofoffice',
      'items',
      'data',
    ]);

    final extracted = <dynamic>[];
    if (raw is List) {
      extracted.addAll(raw);
    } else if (raw is Map<String, dynamic>) {
      final nested = _readAny(raw, ['outOfOffices', 'crewOutOfOffices', 'outofoffice', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    return OutOfOfficeBasicListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(OutOfOfficeDto.fromJson)
          .toList(),
      totalUnapproved: _readInt(json, ['total_unapproved', 'totalUnapproved']) ?? 0,
    );
  }
}

/// Class representing `OutOfOfficeBasicDetailResponse`.
/// Auto-generated class documentation.
class OutOfOfficeBasicDetailResponse {
  final int statusCode;
  final String message;
  final OutOfOfficeBasicDto? detail;

  const OutOfOfficeBasicDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory OutOfOfficeBasicDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'outOfOfficeBasic',
      'basic',
      'detail',
      'data',
    ]);

    return OutOfOfficeBasicDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : OutOfOfficeBasicDto.fromJson(obj),
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
