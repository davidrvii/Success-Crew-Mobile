import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/overtime/data/datasources/overtime_remote_datasource.dart';
import '../../features/overtime/data/repositories/overtime_repository_impl.dart';
import '../../features/overtime/domain/repositories/overtime_repository.dart';
import '../../features/overtime/domain/usecases/get_overtime_list.dart';
import '../../features/overtime/domain/usecases/get_overtime_detail.dart';
import '../../features/overtime/domain/usecases/create_overtime.dart';
import '../../features/overtime/domain/usecases/update_overtime.dart';
import '../../features/overtime/domain/usecases/delete_overtime.dart';
import '../../features/overtime/domain/usecases/get_overtime_basic_all.dart';
import '../../features/overtime/domain/usecases/get_overtime_basic_detail.dart';
import '../../features/overtime/domain/usecases/update_overtime_status.dart';
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
  sl.registerLazySingleton<GetOvertimeDetailUseCase>(
    () => GetOvertimeDetailUseCase(sl<OvertimeRepository>()),
  );
  sl.registerLazySingleton<CreateOvertimeUseCase>(
    () => CreateOvertimeUseCase(sl<OvertimeRepository>()),
  );
  sl.registerLazySingleton<UpdateOvertimeUseCase>(
    () => UpdateOvertimeUseCase(sl<OvertimeRepository>()),
  );
  sl.registerLazySingleton<DeleteOvertimeUseCase>(
    () => DeleteOvertimeUseCase(sl<OvertimeRepository>()),
  );
  sl.registerLazySingleton<GetOvertimeBasicAllUseCase>(
    () => GetOvertimeBasicAllUseCase(sl<OvertimeRepository>()),
  );
  sl.registerLazySingleton<GetOvertimeBasicDetailUseCase>(
    () => GetOvertimeBasicDetailUseCase(sl<OvertimeRepository>()),
  );
  sl.registerLazySingleton<UpdateOvertimeStatusUseCase>(
    () => UpdateOvertimeStatusUseCase(sl<OvertimeRepository>()),
  );

  // Controllers
  sl.registerFactory<OvertimeController>(
    () => OvertimeController(
      getOvertimeList: sl<GetOvertimeListUseCase>(),
      createOvertime: sl<CreateOvertimeUseCase>(),
      updateOvertime: sl<UpdateOvertimeUseCase>(),
      deleteOvertime: sl<DeleteOvertimeUseCase>(),
      userSession: sl<UserSession>(),
    ),
  );
}
