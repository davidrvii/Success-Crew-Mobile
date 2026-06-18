import '../../../../core/network/api_response.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class ReadNotificationUseCase {
  final NotificationRepository _repo;
  const ReadNotificationUseCase(this._repo);

  Future<ApiResponse<AppNotification>> call(int id, bool isRead) =>
      _repo.readNotification(id, isRead);
}
