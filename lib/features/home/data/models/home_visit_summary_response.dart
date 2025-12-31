class HomeVisitSummaryResponse {
  final int statusCode;
  final String message;
  final List<HomeVisitDto> items;

  const HomeVisitSummaryResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory HomeVisitSummaryResponse.fromJson(Map<String, dynamic> json) {
    final list = _extractList(
      json,
      preferredKeys: const ['visits', 'visit', 'visitAdmin', 'data'],
    );

    return HomeVisitSummaryResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: list.map((e) => HomeVisitDto.fromJson(e)).toList(),
    );
  }
}

class HomeVisitDto {
  final int id;
  final DateTime? createdAt;

  /// field tambahan kalau backend punya (pemasukan, jarak, dll)
  final num? revenue;
  final num? distance;

  final Map<String, dynamic> raw;

  const HomeVisitDto({
    required this.id,
    required this.createdAt,
    required this.revenue,
    required this.distance,
    required this.raw,
  });

  factory HomeVisitDto.fromJson(Map<String, dynamic> json) {
    return HomeVisitDto(
      id:
          (json['visit_id'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
      createdAt: _tryParseDateTime(json['created_at'] ?? json['createdAt']),
      revenue:
          (json['total_revenue'] as num?) ??
          (json['income'] as num?) ??
          (json['pemasukkan'] as num?),
      distance:
          (json['total_distance'] as num?) ??
          (json['distance'] as num?) ??
          (json['jarak'] as num?),
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
