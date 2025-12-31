class HomeAbsenceResponse {
  final int statusCode;
  final String message;
  final HomeAbsenceDetailDto? detail;

  const HomeAbsenceResponse({
    required this.statusCode,
    required this.message,
    required this.detail,
  });

  factory HomeAbsenceResponse.fromJson(Map<String, dynamic> json) {
    final payload = _extractMap(
      json,
      preferredKeys: const [
        'attendanceDetail',
        'absenceDetail',
        'detail',
        'attendance',
        'data',
      ],
    );

    return HomeAbsenceResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      detail: payload == null ? null : HomeAbsenceDetailDto.fromJson(payload),
    );
  }
}

class HomeAbsenceDetailDto {
  final int id;
  final DateTime? attendanceDate;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;
  final String? status;

  final Map<String, dynamic> raw;

  const HomeAbsenceDetailDto({
    required this.id,
    required this.attendanceDate,
    required this.checkInAt,
    required this.checkOutAt,
    required this.status,
    required this.raw,
  });

  factory HomeAbsenceDetailDto.fromJson(Map<String, dynamic> json) {
    return HomeAbsenceDetailDto(
      id:
          (json['attendance_id'] as num?)?.toInt() ??
          (json['id'] as num?)?.toInt() ??
          0,
      attendanceDate: _tryParseDateTime(
        json['attendance_date'] ?? json['date'],
      ),
      checkInAt: _tryParseDateTime(
        json['check_in'] ?? json['checkIn'] ?? json['check_in_at'],
      ),
      checkOutAt: _tryParseDateTime(
        json['check_out'] ?? json['checkOut'] ?? json['check_out_at'],
      ),
      status:
          (json['attendance_status'] as String?) ??
          (json['status'] as String?) ??
          (json['type'] as String?),
      raw: json,
    );
  }
}

Map<String, dynamic>? _extractMap(
  Map<String, dynamic> json, {
  required List<String> preferredKeys,
}) {
  for (final k in preferredKeys) {
    final v = json[k];
    if (v is Map<String, dynamic>) return v;
  }
  for (final entry in json.entries) {
    if (entry.key == 'statusCode' || entry.key == 'message') continue;
    if (entry.value is Map<String, dynamic>) {
      return entry.value as Map<String, dynamic>;
    }
  }
  return null;
}

DateTime? _tryParseDateTime(dynamic v) {
  if (v is String) return DateTime.tryParse(v);
  return null;
}
