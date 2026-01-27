import 'package:get_it/get_it.dart';

import '../../../features/home/data/datasources/home_remote_datasource.dart';
import '../../../features/home/data/repositories/home_repository_impl.dart';
import '../../../features/home/domain/repositories/home_repository.dart';
import '../../../features/home/domain/usecases/get_home_summary_request.dart';
import '../../../features/home/domain/usecases/refresh_home_summary_request.dart';
import '../../../features/home/presentation/controllers/home_controller.dart';
import '../../../../core/storage/user_session.dart';

import '../network/dio_client.dart';

void registerHomeDi(GetIt sl) {
  // DataSource
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repository
  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(sl<HomeRemoteDataSource>(), sl<UserSession>()),
  );

  // UseCases
  sl.registerLazySingleton<GetHomeSummaryUseCase>(
    () => GetHomeSummaryUseCase(sl<HomeRepository>()),
  );
  sl.registerLazySingleton<RefreshHomeSummaryUseCase>(
    () => RefreshHomeSummaryUseCase(sl<HomeRepository>()),
  );

  // Controller
  sl.registerFactory<HomeController>(
    () => HomeController(
      getHomeSummaryUseCase: sl<GetHomeSummaryUseCase>(),
      refreshHomeSummaryUseCase: sl<RefreshHomeSummaryUseCase>(),
    ),
  );
}
