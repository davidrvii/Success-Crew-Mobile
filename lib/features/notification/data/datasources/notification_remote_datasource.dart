/// File: lib/features/notification/data/datasources/notification_remote_datasource.dart
/// Generated Documentation for notification_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  /// Method `getNotificationHistory` returning `Future<ApiResponse<NotificationListResponse>>`.
  /// Handles logic operations related to `getNotificationHistory`.
  Future<ApiResponse<NotificationListResponse>> getNotificationHistory(
    int userId,
  );
  /// Method `getNotificationDetail` returning `Future<ApiResponse<NotificationDetailResponse>>`.
  /// Handles logic operations related to `getNotificationDetail`.
  Future<ApiResponse<NotificationDetailResponse>> getNotificationDetail(int id);

  /// Method `getAllNotifications` returning `Future<ApiResponse<NotificationListResponse>>`.
  /// Handles logic operations related to `getAllNotifications`.
  Future<ApiResponse<NotificationListResponse>> getAllNotifications();

  /// Method `createNotification` returning `Future<ApiResponse<CreateNotificationResponse>>`.
  /// Handles logic operations related to `createNotification`.
  Future<ApiResponse<CreateNotificationResponse>> createNotification(
    CreateNotificationRequest request,
  );

  /// Method `updateNotification` returning `Future<ApiResponse<UpdateNotificationResponse>>`.
  /// Handles logic operations related to `updateNotification`.
  Future<ApiResponse<UpdateNotificationResponse>> updateNotification(
    int id,
    UpdateNotificationRequest request,
  );

  /// Method `updateNotificationPut` returning `Future<ApiResponse<UpdateNotificationResponse>>`.
  /// Handles logic operations related to `updateNotificationPut`.
  Future<ApiResponse<UpdateNotificationResponse>> updateNotificationPut(
    int id,
    CreateNotificationRequest request,
  );

  /// Method `readNotification` returning `Future<ApiResponse<UpdateNotificationResponse>>`.
  /// Handles logic operations related to `readNotification`.
  Future<ApiResponse<UpdateNotificationResponse>> readNotification(
    int id,
    bool isRead,
  );

  /// Method `deleteNotification` returning `Future<ApiResponse<DeleteNotificationResponse>>`.
  /// Handles logic operations related to `deleteNotification`.
  Future<ApiResponse<DeleteNotificationResponse>> deleteNotification(int id);

  /// Method `getNotificationBasic` returning `Future<ApiResponse<NotificationBasicDetailResponse>>`.
  /// Handles logic operations related to `getNotificationBasic`.
  Future<ApiResponse<NotificationBasicDetailResponse>> getNotificationBasic(int id);
}

/// Class representing `NotificationRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient _client;
  NotificationRemoteDataSourceImpl(this._client);

  @override
  /// Method `getNotificationHistory` returning `Future<ApiResponse<NotificationListResponse>>`.
  /// Handles logic operations related to `getNotificationHistory`.
  Future<ApiResponse<NotificationListResponse>> getNotificationHistory(
    int userId,
  ) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationHistory(userId)),
      parser: (json) =>
          NotificationListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getNotificationDetail` returning `Future<ApiResponse<NotificationDetailResponse>>`.
  /// Handles logic operations related to `getNotificationDetail`.
  Future<ApiResponse<NotificationDetailResponse>> getNotificationDetail(
    int id,
  ) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationDetail(id)),
      parser: (json) =>
          NotificationDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getAllNotifications` returning `Future<ApiResponse<NotificationListResponse>>`.
  /// Handles logic operations related to `getAllNotifications`.
  Future<ApiResponse<NotificationListResponse>> getAllNotifications() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationAll),
      parser: (json) =>
          NotificationListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createNotification` returning `Future<ApiResponse<CreateNotificationResponse>>`.
  /// Handles logic operations related to `createNotification`.
  Future<ApiResponse<CreateNotificationResponse>> createNotification(
    CreateNotificationRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.post(ApiPaths.notificationAdd, data: request.toJson()),
      parser: (json) =>
          CreateNotificationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateNotification` returning `Future<ApiResponse<UpdateNotificationResponse>>`.
  /// Handles logic operations related to `updateNotification`.
  Future<ApiResponse<UpdateNotificationResponse>> updateNotification(
    int id,
    UpdateNotificationRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.notificationUpdate(id),
        data: request.toJson(),
      ),
      parser: (json) =>
          UpdateNotificationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateNotificationPut` returning `Future<ApiResponse<UpdateNotificationResponse>>`.
  /// Handles logic operations related to `updateNotificationPut`.
  Future<ApiResponse<UpdateNotificationResponse>> updateNotificationPut(
    int id,
    CreateNotificationRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.put(
        ApiPaths.notificationUpdate(id),
        data: request.toJson(),
      ),
      parser: (json) =>
          UpdateNotificationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `readNotification` returning `Future<ApiResponse<UpdateNotificationResponse>>`.
  /// Handles logic operations related to `readNotification`.
  Future<ApiResponse<UpdateNotificationResponse>> readNotification(
    int id,
    bool isRead,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.notificationRead(id),
        data: {'is_read': isRead},
      ),
      parser: (json) =>
          UpdateNotificationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteNotification` returning `Future<ApiResponse<DeleteNotificationResponse>>`.
  /// Handles logic operations related to `deleteNotification`.
  Future<ApiResponse<DeleteNotificationResponse>> deleteNotification(int id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.notificationDelete(id)),
      parser: (json) =>
          DeleteNotificationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getNotificationBasic` returning `Future<ApiResponse<NotificationBasicDetailResponse>>`.
  /// Handles logic operations related to `getNotificationBasic`.
  Future<ApiResponse<NotificationBasicDetailResponse>> getNotificationBasic(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationBasic(id)),
      parser: (json) =>
          NotificationBasicDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
