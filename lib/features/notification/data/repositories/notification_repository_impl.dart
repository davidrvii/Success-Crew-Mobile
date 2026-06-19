/// File: lib/features/notification/data/repositories/notification_repository_impl.dart
/// Generated Documentation for notification_repository_impl.dart

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/notification.dart';
import '../../domain/entities/notification_basic.dart';
import '../../domain/repositories/notification_repository.dart';

import '../datasources/notification_remote_datasource.dart';
import '../models/notification_model.dart';

/// Class representing `NotificationRepositoryImpl`.
/// Auto-generated class documentation.
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource _remote;
  final UserSession _session;

  NotificationRepositoryImpl(this._remote, this._session);

  @override
  /// Method `getNotifications` returning `Future<ApiResponse<List<AppNotification>>>`.
  /// Handles logic operations related to `getNotifications`.
  Future<ApiResponse<List<AppNotification>>> getNotifications() async {
    final userIdRes = await _requireUserId();
    if (!userIdRes.isSuccess) return ApiResponse.failure(userIdRes.error!);

    final int userId = userIdRes.data!;

    final res = await _remote.getNotificationHistory(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.items ?? const <NotificationDto>[];
    return ApiResponse.success(items.map(_mapDtoToEntity).toList());
  }

  @override
  /// Method `getNotificationDetail` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `getNotificationDetail`.
  Future<ApiResponse<AppNotification>> getNotificationDetail(int id) async {
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

  @override
  /// Method `getNotificationBasic` returning `Future<ApiResponse<NotificationBasic>>`.
  /// Handles logic operations related to `getNotificationBasic`.
  Future<ApiResponse<NotificationBasic>> getNotificationBasic(int id) async {
    final res = await _remote.getNotificationBasic(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final detail = res.data?.detail;
    if (detail == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (notification basic detail is null).',
        ),
      );
    }

    return ApiResponse.success(NotificationBasic(
      id: detail.id,
      isRead: detail.isRead,
      totalUnread: detail.totalUnread,
    ));
  }

  @override
  /// Method `createNotification` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `createNotification`.
  Future<ApiResponse<AppNotification>> createNotification(
    CreateNotificationRequest request,
  ) async {
    final res = await _remote.createNotification(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.notification;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (created notification is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  /// Method `updateNotification` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `updateNotification`.
  Future<ApiResponse<AppNotification>> updateNotification(
    int id,
    UpdateNotificationRequest request,
  ) async {
    final res = await _remote.updateNotification(id, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.notification;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (updated notification is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  /// Method `updateNotificationPut` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `updateNotificationPut`.
  Future<ApiResponse<AppNotification>> updateNotificationPut(
    int id,
    CreateNotificationRequest request,
  ) async {
    final res = await _remote.updateNotificationPut(id, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.notification;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (updated notification is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  /// Method `readNotification` returning `Future<ApiResponse<AppNotification>>`.
  /// Handles logic operations related to `readNotification`.
  Future<ApiResponse<AppNotification>> readNotification(
    int id,
    bool isRead,
  ) async {
    final res = await _remote.readNotification(id, isRead);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.notification;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (notification status is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  /// Method `deleteNotification` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteNotification`.
  Future<ApiResponse<int>> deleteNotification(int id) async {
    final res = await _remote.deleteNotification(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final deletedId = res.data?.notificationId;
    if (deletedId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (deleted notificationId is null).',
        ),
      );
    }

    return ApiResponse.success(deletedId);
  }

  // ========= helpers =========

  /// Method `_requireUserId` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `_requireUserId`.
  Future<ApiResponse<int>> _requireUserId() async {
    final int? userId = await _session.readUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }
    return ApiResponse.success(userId);
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
