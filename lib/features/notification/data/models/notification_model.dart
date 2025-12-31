class NotificationDto {
  final int id;
  final int userId;

  final String? title;
  final String? description;

  final bool isRead;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const NotificationDto({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationDto.fromJson(Map<String, dynamic> json) {
    return NotificationDto(
      id: _readInt(json, ['notification_id', 'id', 'notificationId']) ?? 0,
      userId: _readInt(json, ['user_id', 'userId']) ?? 0,
      title: _readString(json, ['notification_title', 'title']) ?? '',
      description:
          _readString(json, ['notification_desc', 'description', 'desc']) ?? '',
      isRead: _readBool(json, ['is_read', 'isRead', 'read_status', 'status']),
      createdAt: _readDate(json, ['created_at', 'createdAt']),
      updatedAt: _readDate(json, ['updated_at', 'updatedAt']),
    );
  }
}

/// LIST RESPONSE

class NotificationListResponse {
  final int statusCode;
  final String message;
  final List<NotificationDto> items;

  const NotificationListResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    final raw = _readAny(json, [
      'notifications',
      'notificationHistory',
      'notification',
      'items',
      'data',
    ]);

    final extracted = <dynamic>[];
    if (raw is List) {
      extracted.addAll(raw);
    } else if (raw is Map<String, dynamic>) {
      final nested = _readAny(raw, ['notifications', 'items', 'data']);
      if (nested is List) extracted.addAll(nested);
    }

    return NotificationListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: extracted
          .whereType<Map<String, dynamic>>()
          .map(NotificationDto.fromJson)
          .toList(),
    );
  }
}

/// DETAIL RESPONSE

class NotificationDetailResponse {
  final int statusCode;
  final String message;
  final NotificationDto? detail;

  const NotificationDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory NotificationDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'notificationDetail',
      'notification',
      'detail',
      'data',
    ]);

    return NotificationDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : NotificationDto.fromJson(obj),
    );
  }
}

/// CREATE REQUEST/RESPONSE

class CreateNotificationRequest {
  final int userId;
  final String title;
  final String description;

  final bool? isRead;

  const CreateNotificationRequest({
    required this.userId,
    required this.title,
    required this.description,
    this.isRead,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'notification_title': title,
      'notification_desc': description,
      if (isRead != null) 'is_read': isRead,
    };
  }
}

class CreateNotificationResponse {
  final int statusCode;
  final String message;
  final NotificationDto? notification;

  const CreateNotificationResponse({
    required this.statusCode,
    required this.message,
    required this.notification,
  });

  factory CreateNotificationResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'newNotification',
      'createdNotification',
      'notification',
      'data',
    ]);

    return CreateNotificationResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      notification: obj == null ? null : NotificationDto.fromJson(obj),
    );
  }
}

/// UPDATE REQUEST/RESPONSE

class UpdateNotificationRequest {
  final bool? isRead;

  const UpdateNotificationRequest({this.isRead});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (isRead != null) map['is_read'] = isRead;
    return map;
  }
}

class UpdateNotificationResponse {
  final int statusCode;
  final String message;
  final NotificationDto? notification;

  const UpdateNotificationResponse({
    required this.statusCode,
    required this.message,
    required this.notification,
  });

  factory UpdateNotificationResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, ['updatedNotification', 'notification', 'data']);

    return UpdateNotificationResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      notification: obj == null ? null : NotificationDto.fromJson(obj),
    );
  }
}

/// DELETE RESPONSE

class DeleteNotificationResponse {
  final int statusCode;
  final String message;
  final int? notificationId;

  const DeleteNotificationResponse({
    required this.statusCode,
    required this.message,
    required this.notificationId,
  });

  factory DeleteNotificationResponse.fromJson(Map<String, dynamic> json) {
    final id =
        _readInt(json, ['notificationId', 'notification_id', 'id']) ??
        _readInt(_readMap(json, ['data', 'result']) ?? const {}, [
          'notificationId',
          'id',
        ]);

    return DeleteNotificationResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      notificationId: id,
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

bool _readBool(Map<String, dynamic> json, List<String> keys) {
  for (final k in keys) {
    final v = json[k];
    if (v is bool) return v;
    if (v is num) return v.toInt() == 1;
    if (v is String) {
      final s = v.toLowerCase().trim();
      if (s == 'true' || s == '1' || s == 'read') return true;
      if (s == 'false' || s == '0' || s == 'unread') return false;
    }
  }
  return false;
}
