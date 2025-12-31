import '../../../../core/network/api_response.dart';
import '../entities/notification.dart';

abstract class NotificationRepository {
  Future<ApiResponse<List<AppNotification>>> getNotifications();
  Future<ApiResponse<AppNotification>> getNotificationDetail(String id);
}
