import '../../../../core/network/api_response.dart';
import '../../data/models/notification_model.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class CreateNotificationUseCase {
  final NotificationRepository _repo;
  const CreateNotificationUseCase(this._repo);

  Future<ApiResponse<AppNotification>> call(CreateNotificationRequest request) =>
      _repo.createNotification(request);
}
