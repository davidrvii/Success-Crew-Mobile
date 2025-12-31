import '../../../../core/network/api_response.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class GetNotificationDetailUseCase {
  final NotificationRepository _repo;
  const GetNotificationDetailUseCase(this._repo);

  Future<ApiResponse<AppNotification>> call(String id) {
    return _repo.getNotificationDetail(id);
  }
}
