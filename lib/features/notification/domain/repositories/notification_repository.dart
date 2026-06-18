import '../../../../core/network/api_response.dart';
import '../../data/models/notification_model.dart';
import '../entities/notification.dart';
import '../entities/notification_basic.dart';

abstract class NotificationRepository {
  Future<ApiResponse<List<AppNotification>>> getNotifications();
  Future<ApiResponse<AppNotification>> getNotificationDetail(int id);
  Future<ApiResponse<NotificationBasic>> getNotificationBasic(int id);

  Future<ApiResponse<AppNotification>> createNotification(
    CreateNotificationRequest request,
  );
  Future<ApiResponse<AppNotification>> updateNotification(
    int id,
    UpdateNotificationRequest request,
  );
  Future<ApiResponse<AppNotification>> updateNotificationPut(
    int id,
    CreateNotificationRequest request,
  );
  Future<ApiResponse<AppNotification>> readNotification(int id, bool isRead);

  Future<ApiResponse<int>> deleteNotification(int id);
}
