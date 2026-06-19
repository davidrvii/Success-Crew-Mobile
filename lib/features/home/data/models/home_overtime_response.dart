/// File: lib/features/home/data/models/home_overtime_response.dart
/// Generated Documentation for home_overtime_response.dart

/// Class representing `HomeOvertimeResponse`.
/// Auto-generated class documentation.
class HomeOvertimeResponse {
  final int pendingCount;

  HomeOvertimeResponse({required this.pendingCount});

  factory HomeOvertimeResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['overtimes'] ?? json['crewOvertimes'] ?? json['data'];
    if (raw is List) {
      final pending = raw.where((item) {
        if (item is Map<String, dynamic>) {
          final status = (item['overtime_status'] as String?)?.toLowerCase() ?? '';
          return status == 'pending';
        }
        return false;
      }).length;
      return HomeOvertimeResponse(pendingCount: pending);
    }
    return HomeOvertimeResponse(
      pendingCount: (json['pending_overtime'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'pending_overtime': pendingCount};
  }
}
