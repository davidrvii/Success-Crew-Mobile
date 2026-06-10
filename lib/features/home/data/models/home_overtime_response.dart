class HomeOvertimeResponse {
  final int pendingCount;

  HomeOvertimeResponse({required this.pendingCount});

  factory HomeOvertimeResponse.fromJson(Map<String, dynamic> json) {
    return HomeOvertimeResponse(
      pendingCount: (json['pending_overtime'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'pending_overtime': pendingCount};
  }
}
