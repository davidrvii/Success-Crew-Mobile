/// File: lib/features/home/data/models/home_out_of_office_response.dart
/// Generated Documentation for home_out_of_office_response.dart

/// Class representing `HomeOutOfOfficeResponse`.
/// Auto-generated class documentation.
class HomeOutOfOfficeResponse {
  final int pendingCount;

  HomeOutOfOfficeResponse({required this.pendingCount});

  factory HomeOutOfOfficeResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['outOfOffices'] ?? json['crewOutOfOffices'] ?? json['outofoffice'] ?? json['data'];
    if (raw is List) {
      final pending = raw.where((item) {
        if (item is Map<String, dynamic>) {
          final status = (item['out_of_office_status'] ?? item['outofoffice_status'] as String?)?.toLowerCase() ?? '';
          return status == 'pending';
        }
        return false;
      }).length;
      return HomeOutOfOfficeResponse(pendingCount: pending);
    }
    return HomeOutOfOfficeResponse(
      pendingCount: (json['pending_outofoffice'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'pending_outofoffice': pendingCount};
  }
}
