class HomeAttendanceResponse {
  final int statusCode;
  final String message;
  final List<HomeAttendanceDto> items;

  const HomeAttendanceResponse({
    required this.statusCode,
    required this.message,
    required this.items,
  });

  factory HomeAttendanceResponse.fromJson(Map<String, dynamic> json) {
    final list = _extractList(
      json,
      preferredKeys: const [
        'attendanceCrew',
        'crewAttendance',
        'attendances',
        'attendance',
        'data',
      ],
    );

    return HomeAttendanceResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      items: list.map((e) => HomeAttendanceDto.fromJson(e)).toList(),
    );
  }
}

class HomeAttendanceDto {
  final int id;
  final DateTime? attendanceDate;
  final DateTime? checkInAt;
  final DateTime? checkOutAt;
  final String? status;

  final Map<String, dynamic> raw;

  const HomeAttendanceDto({
    required this.id,
    required this.attendanceDate,
    required this.checkInAt,
    required this.checkOutAt,
    required this.status,
    required this.raw,
  });

  factory HomeAttendanceDto.fromJson(Map<String, dynamic> json) {
    return HomeAttendanceDto(
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
