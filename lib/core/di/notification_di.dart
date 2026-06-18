import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/notification/data/datasources/notification_remote_datasource.dart';
import '../../features/notification/data/repositories/notification_repository_impl.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';
import '../../features/notification/domain/usecases/get_notifications.dart';
import '../../features/notification/domain/usecases/get_notification_detail.dart';
import '../../features/notification/domain/usecases/create_notification.dart';
import '../../features/notification/domain/usecases/update_notification.dart';
import '../../features/notification/domain/usecases/read_notification.dart';
import '../../features/notification/domain/usecases/delete_notification.dart';
import '../../features/notification/domain/usecases/get_notification_basic.dart';
import '../../features/notification/presentation/controllers/notification_controller.dart';

void registerNotificationDi(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repositories
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(sl<NotificationRemoteDataSource>(), sl<UserSession>()),
  );

  // UseCases
  sl.registerLazySingleton<GetNotificationsUseCase>(
    () => GetNotificationsUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<GetNotificationDetailUseCase>(
    () => GetNotificationDetailUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<CreateNotificationUseCase>(
    () => CreateNotificationUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<UpdateNotificationUseCase>(
    () => UpdateNotificationUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<ReadNotificationUseCase>(
    () => ReadNotificationUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<DeleteNotificationUseCase>(
    () => DeleteNotificationUseCase(sl<NotificationRepository>()),
  );
  sl.registerLazySingleton<GetNotificationBasicUseCase>(
    () => GetNotificationBasicUseCase(sl<NotificationRepository>()),
  );

  // Controllers
  sl.registerFactory<NotificationController>(
    () => NotificationController(
      getNotifications: sl<GetNotificationsUseCase>(),
    ),
  );
}
