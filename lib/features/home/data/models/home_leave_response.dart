class HomeLeaveResponse {
  final int pendingCount;

  HomeLeaveResponse({required this.pendingCount});

  factory HomeLeaveResponse.fromJson(Map<String, dynamic> json) {
    return HomeLeaveResponse(pendingCount: (json['pending_leave'] as num?)?.toInt() ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {'pending_leave': pendingCount};
  }
}
