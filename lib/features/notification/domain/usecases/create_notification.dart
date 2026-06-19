/// File: lib/features/notification/domain/usecases/create_notification.dart
/// Generated Documentation for create_notification.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/notification_model.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// Class representing `CreateNotificationUseCase`.
/// Auto-generated class documentation.
class CreateNotificationUseCase {
  final NotificationRepository _repo;
  const CreateNotificationUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<AppNotification>> call(CreateNotificationRequest request) =>
      _repo.createNotification(request);
}
