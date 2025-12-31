import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<ApiResponse<NotificationListResponse>> getNotificationHistory(
    String userId,
  );
  Future<ApiResponse<NotificationDetailResponse>> getNotificationDetail(
    String id,
  );

  Future<ApiResponse<NotificationListResponse>> getAllNotificationsAdmin();

  Future<ApiResponse<CreateNotificationResponse>> createNotification(
    CreateNotificationRequest request,
  );

  Future<ApiResponse<UpdateNotificationResponse>> updateNotification(
    String id,
    UpdateNotificationRequest request,
  );

  Future<ApiResponse<DeleteNotificationResponse>> deleteNotification(String id);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final DioClient _client;
  NotificationRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<NotificationListResponse>> getNotificationHistory(
    String userId,
  ) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationHistory(userId)),
      parser: (json) =>
          NotificationListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<NotificationDetailResponse>> getNotificationDetail(
    String id,
  ) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationDetail(id)),
      parser: (json) =>
          NotificationDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<NotificationListResponse>> getAllNotificationsAdmin() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.notificationAdmin),
      parser: (json) =>
          NotificationListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
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
  Future<ApiResponse<UpdateNotificationResponse>> updateNotification(
    String id,
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
  Future<ApiResponse<DeleteNotificationResponse>> deleteNotification(
    String id,
  ) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.notificationDelete(id)),
      parser: (json) =>
          DeleteNotificationResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
