/// File: lib/features/notification/domain/usecases/get_notifications.dart
/// Generated Documentation for get_notifications.dart

import '../../../../core/network/api_response.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Class representing `GetNotificationsUseCase`.
/// Auto-generated class documentation.
class GetNotificationsUseCase {
  final NotificationRepository _repo;
  const GetNotificationsUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<List<AppNotification>>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<List<AppNotification>>> call() {
    return _repo.getNotifications();
  }
}
