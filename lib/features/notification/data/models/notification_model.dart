/// File: lib/features/notification/data/models/notification_model.dart
/// Generated Documentation for notification_model.dart

/// Class representing `NotificationDto`.
/// Auto-generated class documentation.
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

/// Class representing `NotificationListResponse`.
/// Auto-generated class documentation.
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
      'notificationsHistory',
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
      final nested = _readAny(raw, ['notificationsHistory', 'notifications', 'items', 'data']);
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

/// Class representing `NotificationDetailResponse`.
/// Auto-generated class documentation.
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

/// Class representing `CreateNotificationRequest`.
/// Auto-generated class documentation.
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

/// Class representing `CreateNotificationResponse`.
/// Auto-generated class documentation.
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
      'notificationCreated',
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

/// Class representing `UpdateNotificationRequest`.
/// Auto-generated class documentation.
class UpdateNotificationRequest {
  final String? title;
  final String? description;
  final bool? isRead;

  const UpdateNotificationRequest({
    this.title,
    this.description,
    this.isRead,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (title != null) map['notification_title'] = title;
    if (description != null) map['notification_desc'] = description;
    if (isRead != null) map['is_read'] = isRead;
    return map;
  }
}

/// Class representing `UpdateNotificationResponse`.
/// Auto-generated class documentation.
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
    final obj = _readMap(json, [
      'notificationRead',
      'notificationUpdated',
      'updatedNotification',
      'notification',
      'data',
    ]);

    return UpdateNotificationResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      notification: obj == null ? null : NotificationDto.fromJson(obj),
    );
  }
}

/// DELETE RESPONSE

/// Class representing `DeleteNotificationResponse`.
/// Auto-generated class documentation.
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

/// BASIC DTO AND RESPONSES

/// Class representing `NotificationBasicDto`.
/// Auto-generated class documentation.
class NotificationBasicDto {
  final int id;
  final bool isRead;
  final int totalUnread;

  const NotificationBasicDto({
    required this.id,
    required this.isRead,
    required this.totalUnread,
  });

  factory NotificationBasicDto.fromJson(Map<String, dynamic> json) {
    return NotificationBasicDto(
      id: _readInt(json, ['notification_id', 'id', 'notificationId']) ?? 0,
      isRead: _readBool(json, ['is_read', 'isRead', 'read_status']),
      totalUnread: _readInt(json, ['total_unread', 'totalUnread']) ?? 0,
    );
  }
}

/// Class representing `NotificationBasicDetailResponse`.
/// Auto-generated class documentation.
class NotificationBasicDetailResponse {
  final int statusCode;
  final String message;
  final NotificationBasicDto? detail;

  const NotificationBasicDetailResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory NotificationBasicDetailResponse.fromJson(Map<String, dynamic> json) {
    final obj = _readMap(json, [
      'notificationBasic',
      'basic',
      'detail',
      'data',
    ]);

    return NotificationBasicDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: obj == null ? null : NotificationBasicDto.fromJson(obj),
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

/// Method `_readBool` returning `bool`.
/// Handles logic operations related to `_readBool`.
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
