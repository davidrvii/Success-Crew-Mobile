/// File: lib/features/home/data/models/home_notification_response.dart
/// Generated Documentation for home_notification_response.dart

/// Class representing `HomeNotificationResponse`.
/// Auto-generated class documentation.
class HomeNotificationResponse {
  final int unreadCount;

  HomeNotificationResponse({required this.unreadCount});

  factory HomeNotificationResponse.fromJson(Map<String, dynamic> json) {
    return HomeNotificationResponse(
      unreadCount: (json['unread_count'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'unread_count': unreadCount};
  }
}
