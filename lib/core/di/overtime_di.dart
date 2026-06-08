import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/overtime/data/datasources/overtime_remote_datasource.dart';
import '../../features/overtime/data/repositories/overtime_repository_impl.dart';
import '../../features/overtime/domain/repositories/overtime_repository.dart';
import '../../features/overtime/domain/usecases/get_overtime_list.dart';
import '../../features/overtime/domain/usecases/create_overtime.dart';
import '../../features/overtime/presentation/controllers/overtime_controller.dart';

void registerOvertimeDi(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<OvertimeRemoteDataSource>(
    () => OvertimeRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repositories
  sl.registerLazySingleton<OvertimeRepository>(
    () => OvertimeRepositoryImpl(sl<OvertimeRemoteDataSource>(), sl<UserSession>()),
  );

  // UseCases
  sl.registerLazySingleton<GetOvertimeListUseCase>(
    () => GetOvertimeListUseCase(sl<OvertimeRepository>()),
  );
  sl.registerLazySingleton<CreateOvertimeUseCase>(
    () => CreateOvertimeUseCase(sl<OvertimeRepository>()),
  );

  // Controllers
  sl.registerFactory<OvertimeController>(
    () => OvertimeController(
      getOvertimeList: sl<GetOvertimeListUseCase>(),
      createOvertime: sl<CreateOvertimeUseCase>(),
    ),
  );
}
