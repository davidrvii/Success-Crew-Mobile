class HomeNotificationResponse {
  final int unreadCount;

  HomeNotificationResponse({required this.unreadCount});

  factory HomeNotificationResponse.fromJson(Map<String, dynamic> json) {
    return HomeNotificationResponse(
      unreadCount: json['unread_count'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'unread_count': unreadCount};
  }
}
