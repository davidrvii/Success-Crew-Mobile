class HomeLeaveResponse {
  final int pendingCount;

  HomeLeaveResponse({required this.pendingCount});

  factory HomeLeaveResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['leaves'] ?? json['crewLeaves'] ?? json['data'];
    if (raw is List) {
      final pending = raw.where((item) {
        if (item is Map<String, dynamic>) {
          final status = (item['leave_status'] as String?)?.toLowerCase() ?? '';
          return status == 'pending';
        }
        return false;
      }).length;
      return HomeLeaveResponse(pendingCount: pending);
    }
    return HomeLeaveResponse(pendingCount: (json['pending_leave'] as num?)?.toInt() ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'pending_leave': pendingCount};
  }
}
