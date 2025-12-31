class HomeLeaveResponse {
  final int statusCode;
  final String message;
  final List<HomeLeaveDto> items;

  const HomeLeaveResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory HomeLeaveResponse.fromJson(Map<String, dynamic> json) {
    final list = _extractList(
      json,
      preferredKeys: const [
        'leaveCrew',
        'crewLeave',
        'leaves',
        'leave',
        'data',
      ],
    );

    return HomeLeaveResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: list.map((e) => HomeLeaveDto.fromJson(e)).toList(),
    );
  }
}

class HomeLeaveDto {
  final int id;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;

  final Map<String, dynamic> raw;

  const HomeLeaveDto({
    required this.id,
    required this.status,
    required this.startDate,
    required this.endDate,
    required this.raw,
  });

  factory HomeLeaveDto.fromJson(Map<String, dynamic> json) {
    return HomeLeaveDto(
      id:
          (json['leave_id'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
      status: (json['leave_status'] as String?) ?? (json['status'] as String?),
      startDate: _tryParseDateTime(json['start_date'] ?? json['leave_start']),
      endDate: _tryParseDateTime(json['end_date'] ?? json['leave_end']),
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
