class HomeOvertimeResponse {
  final int statusCode;
  final String message;
  final List<HomeOvertimeDto> items;

  const HomeOvertimeResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory HomeOvertimeResponse.fromJson(Map<String, dynamic> json) {
    final list = _extractList(
      json,
      preferredKeys: const [
        'overtimeCrew',
        'crewOvertime',
        'overtimes',
        'overtime',
        'data',
      ],
    );

    return HomeOvertimeResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: list.map((e) => HomeOvertimeDto.fromJson(e)).toList(),
    );
  }
}

class HomeOvertimeDto {
  final int id;
  final String? status;
  final DateTime? date;
  final num? hours;

  final Map<String, dynamic> raw;

  const HomeOvertimeDto({
    required this.id,
    required this.status,
    required this.date,
    required this.hours,
    required this.raw,
  });

  factory HomeOvertimeDto.fromJson(Map<String, dynamic> json) {
    return HomeOvertimeDto(
      id:
          (json['overtime_id'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
      status:
          (json['overtime_status'] as String?) ?? (json['status'] as String?),
      date: _tryParseDateTime(json['overtime_date'] ?? json['date']),
      hours: (json['hours'] as num?) ?? (json['duration'] as num?),
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

DateTime? _tryParseDateTime(dynamic v) {
  if (v is String) return DateTime.tryParse(v);
  return null;
}
