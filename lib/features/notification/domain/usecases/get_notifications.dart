import '../../../../core/network/api_response.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class GetNotificationsUseCase {
  final NotificationRepository _repo;
  const GetNotificationsUseCase(this._repo);

  Future<ApiResponse<List<AppNotification>>> call() {
    return _repo.getNotifications();
  }
}
