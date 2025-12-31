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

  bool get isUnread => !isRead;
}
