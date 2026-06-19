/// File: lib/features/notification/domain/entities/notification.dart
/// Generated Documentation for notification.dart

/// Class representing `AppNotification`.
/// Auto-generated class documentation.
class AppNotification {
  final int id;
  final int userId;

  final String? title;
  final String? description;

  final bool isRead;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AppNotification({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.isRead,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Getter for `isUnread` returning `bool`.
  bool get isUnread => !isRead;
}
