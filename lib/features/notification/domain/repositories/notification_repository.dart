/// File: lib/features/notification/domain/repositories/notification_repository.dart
/// Generated Documentation for notification_repository.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/notification_model.dart';
import '../entities/notification.dart';
import '../entities/notification_basic.dart';

abstract class NotificationRepository {
  /// Method `getNotifications` returning `Future<ApiResponse<List<AppNotification>>>`.
  /// Handles logic operations related to `getNotifications`.
  Future<ApiResponse<List<AppNotification>>> getNotifications();
  /// Method `getNotificationDetail` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `getNotificationDetail`.
  Future<ApiResponse<AppNotification>> getNotificationDetail(int id);
  /// Method `getNotificationBasic` returning `Future<ApiResponse<NotificationBasic>>`.
  /// Handles logic operations related to `getNotificationBasic`.
  Future<ApiResponse<NotificationBasic>> getNotificationBasic(int id);

  /// Method `createNotification` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `createNotification`.
  Future<ApiResponse<AppNotification>> createNotification(
    CreateNotificationRequest request,
  );
  /// Method `updateNotification` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `updateNotification`.
  Future<ApiResponse<AppNotification>> updateNotification(
    int id,
    UpdateNotificationRequest request,
  );
  /// Method `updateNotificationPut` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `updateNotificationPut`.
  Future<ApiResponse<AppNotification>> updateNotificationPut(
    int id,
    CreateNotificationRequest request,
  );
  /// Method `readNotification` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `readNotification`.
  Future<ApiResponse<AppNotification>> readNotification(int id, bool isRead);

  /// Method `deleteNotification` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteNotification`.
  Future<ApiResponse<int>> deleteNotification(int id);
}
