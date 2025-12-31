class HomeNotificationResponse {
  final int statusCode;
  final String message;
  final List<HomeNotificationDto> items;

  const HomeNotificationResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory HomeNotificationResponse.fromJson(Map<String, dynamic> json) {
    final list = _extractList(
      json,
      preferredKeys: const [
        'notificationHistory',
        'historyNotification',
        'notifications',
        'notification',
        'data',
      ],
    );

    return HomeNotificationResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: list.map((e) => HomeNotificationDto.fromJson(e)).toList(),
    );
  }
}

class HomeNotificationDto {
  final int id;
  final String title;
  final String? description;
  final bool? isRead;
  final DateTime? createdAt;

  /// kalau backend beda-beda fieldnya, raw ini penyelamat.
  final Map<String, dynamic> raw;

  const HomeNotificationDto({
    required this.id,
    required this.title,
    required this.description,
    required this.isRead,
    required this.createdAt,
    required this.raw,
  });

  factory HomeNotificationDto.fromJson(Map<String, dynamic> json) {
    return HomeNotificationDto(
      id:
          (json['notification_id'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
      title:
          (json['title'] as String?) ??
          (json['notification_title'] as String?) ??
          '',
      description:
          (json['description'] as String?) ??
          (json['notification_desc'] as String?) ??
          (json['body'] as String?),
      isRead: _toBoolOrNull(json['is_read'] ?? json['isRead'] ?? json['read']),
      createdAt: _tryParseDateTime(json['created_at'] ?? json['createdAt']),
      raw: json,
    );
  }
}

List<Map<String, dynamic>> _extractList(
  Map<String, dynamic> json, {
  required List<String> preferredKeys,
}) {
  for (final k in preferredKeys) {
    final v = json[k];
    if (v is List) {
      return v
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
  }
  for (final entry in json.entries) {
    if (entry.key == 'statusCode' || entry.key == 'message') continue;
    if (entry.value is List) {
      final v = entry.value as List;
      return v
          .whereType<Map>()
          .map((e) => Map<String, dynamic>.from(e))
          .toList();
    }
  }
  return <Map<String, dynamic>>[];
}

bool? _toBoolOrNull(dynamic v) {
  if (v is bool) return v;
  if (v is num) return v != 0;
  if (v is String) {
    final s = v.toLowerCase();
    if (s == 'true' || s == '1') return true;
    if (s == 'false' || s == '0') return false;
  }
  return null;
}

DateTime? _tryParseDateTime(dynamic v) {
  if (v is String) return DateTime.tryParse(v);
  return null;
}
