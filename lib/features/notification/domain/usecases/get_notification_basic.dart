/// File: lib/features/notification/domain/usecases/get_notification_basic.dart
/// Generated Documentation for get_notification_basic.dart

import '../../../../core/network/api_response.dart';
import '../entities/notification_basic.dart';
import '../repositories/notification_repository.dart';

/// Class representing `GetNotificationBasicUseCase`.
/// Auto-generated class documentation.
class GetNotificationBasicUseCase {
  final NotificationRepository _repo;
  const GetNotificationBasicUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<NotificationBasic>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<NotificationBasic>> call(int id) => _repo.getNotificationBasic(id);
}
