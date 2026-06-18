import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../data/models/notification_model.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

class UpdateNotificationUseCase {
  final NotificationRepository _repo;
  const UpdateNotificationUseCase(this._repo);

  Future<ApiResponse<AppNotification>> call(int id, dynamic request) {
    if (request is CreateNotificationRequest) {
      return _repo.updateNotificationPut(id, request);
    } else if (request is UpdateNotificationRequest) {
      return _repo.updateNotification(id, request);
    }
    return Future.value(ApiResponse.failure(
      NetworkException(
        type: NetworkErrorType.unknown,
        message: 'Invalid request type for UpdateNotificationUseCase.',
      ),
    ));
  }
}
