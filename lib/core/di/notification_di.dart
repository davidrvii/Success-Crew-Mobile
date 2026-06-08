import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/notification/data/datasources/notification_remote_datasource.dart';
import '../../features/notification/data/repositories/notification_repository_impl.dart';
import '../../features/notification/domain/repositories/notification_repository.dart';
import '../../features/notification/domain/usecases/get_notifications.dart';
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

  // Controllers
  sl.registerFactory<NotificationController>(
    () => NotificationController(
      getNotifications: sl<GetNotificationsUseCase>(),
    ),
  );
}
