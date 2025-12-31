import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';

import '../datasources/notification_remote_datasource.dart';
import '../models/notification_model.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remote;
  final UserSession _session;

  NotificationRepositoryImpl(this._remote, this._session);

  @override
  Future<ApiResponse<List<AppNotification>>> getNotifications() async {
    final userId = await _requireUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }

    final res = await _remote.getNotificationHistory(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.items ?? const <NotificationDto>[];
    return ApiResponse.success(items.map(_mapDtoToEntity).toList());
  }

  @override
  Future<ApiResponse<AppNotification>> getNotificationDetail(String id) async {
    final res = await _remote.getNotificationDetail(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.detail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (notification detail is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  // ========= helpers =========

  Future<String?> _requireUserId() async {
    final session = await _session.readSession();
    final userId = session?['user_id']?.toString();
    if (userId == null || userId.isEmpty) return null;
    return userId;
  }

  AppNotification _mapDtoToEntity(NotificationDto dto) {
    return AppNotification(
      id: dto.id,
      userId: dto.userId,
      title: dto.title,
      description: dto.description,
      isRead: dto.isRead,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
