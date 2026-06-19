/// File: lib/features/notification/domain/usecases/read_notification.dart
/// Generated Documentation for read_notification.dart

import '../../../../core/network/api_response.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Class representing `ReadNotificationUseCase`.
/// Auto-generated class documentation.
class ReadNotificationUseCase {
  final NotificationRepository _repo;
  const ReadNotificationUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AppNotification>> call(int id, bool isRead) =>
      _repo.readNotification(id, isRead);
}
