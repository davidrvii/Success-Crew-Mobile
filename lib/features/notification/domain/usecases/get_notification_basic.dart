import '../../../../core/network/api_response.dart';
import '../entities/notification_basic.dart';
import '../repositories/notification_repository.dart';

class GetNotificationBasicUseCase {
  final NotificationRepository _repo;
  const GetNotificationBasicUseCase(this._repo);

  Future<ApiResponse<NotificationBasic>> call(int id) => _repo.getNotificationBasic(id);
}
