/// File: lib/features/notification/domain/usecases/update_notification.dart
/// Generated Documentation for update_notification.dart

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../data/models/notification_model.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Class representing `UpdateNotificationUseCase`.
/// Auto-generated class documentation.
class UpdateNotificationUseCase {
  final NotificationRepository _repo;
  const UpdateNotificationUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AppNotification>> call(int id, dynamic request) {
    if (request is CreateNotificationRequest) {
      return _repo.updateNotificationPut(id, request);
    } else if (request is UpdateNotificationRequest) {
      return _repo.updateNotification(id, request);
    }
    return Future.value(ApiResponse.failure(
      NetworkException(
        type: NetworkErrorType.unknown,
        message: 'Invalid request type for UpdateNotificationUseCase.',
      ),
    ));
  }
}
