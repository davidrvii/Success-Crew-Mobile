import '../../../../core/network/api_response.dart';
import '../repositories/notification_repository.dart';

class DeleteNotificationUseCase {
  final NotificationRepository _repo;
  const DeleteNotificationUseCase(this._repo);

  Future<ApiResponse<int>> call(int id) => _repo.deleteNotification(id);
}
