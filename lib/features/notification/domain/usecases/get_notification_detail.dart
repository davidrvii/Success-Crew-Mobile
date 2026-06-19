/// File: lib/features/notification/domain/usecases/get_notification_detail.dart
/// Generated Documentation for get_notification_detail.dart

import '../../../../core/network/api_response.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Class representing `GetNotificationDetailUseCase`.
/// Auto-generated class documentation.
class GetNotificationDetailUseCase {
  final NotificationRepository _repo;
  const GetNotificationDetailUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AppNotification>> call(int id) {
    return _repo.getNotificationDetail(id);
  }
}
