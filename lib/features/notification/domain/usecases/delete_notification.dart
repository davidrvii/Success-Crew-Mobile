/// File: lib/features/notification/domain/usecases/delete_notification.dart
/// Generated Documentation for delete_notification.dart

import '../../../../core/network/api_response.dart';
import '../repositories/notification_repository.dart';

/// Class representing `DeleteNotificationUseCase`.
/// Auto-generated class documentation.
class DeleteNotificationUseCase {
  final NotificationRepository _repo;
  const DeleteNotificationUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<int>> call(int id) => _repo.deleteNotification(id);
}
