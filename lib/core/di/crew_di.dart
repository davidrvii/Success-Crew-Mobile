import 'package:get_it/get_it.dart';
import '../../features/crew/data/datasources/crew_remote_datasource.dart';
import '../../features/crew/data/repositories/crew_repository_impl.dart';
import '../../features/crew/domain/repositories/crew_repository.dart';
import '../../features/crew/domain/usecases/get_crew_list.dart';
import '../../features/crew/domain/usecases/get_crew_detail.dart';
import '../../features/crew/domain/usecases/get_crew_attendance_history.dart';
import '../../features/crew/presentation/controllers/crew_controller.dart';
import '../../features/crew/presentation/controllers/crew_detail_controller.dart';
import '../network/dio_client.dart';

void registerCrewDi(GetIt sl) {
  // DataSource
  sl.registerLazySingleton<CrewRemoteDataSource>(
    () => CrewRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repository
  sl.registerLazySingleton<CrewRepository>(
    () => CrewRepositoryImpl(sl<CrewRemoteDataSource>()),
  );

  // UseCases
  sl.registerLazySingleton<GetCrewListUseCase>(
    () => GetCrewListUseCase(sl<CrewRepository>()),
  );
  sl.registerLazySingleton<GetCrewDetailUseCase>(
    () => GetCrewDetailUseCase(sl<CrewRepository>()),
  );
  sl.registerLazySingleton<GetCrewAttendanceHistoryUseCase>(
    () => GetCrewAttendanceHistoryUseCase(sl<CrewRepository>()),
  );

  // Controller
  sl.registerFactory<CrewController>(
    () => CrewController(
      getCrewListUseCase: sl<GetCrewListUseCase>(),
    ),
  );
  sl.registerFactory<CrewDetailController>(
    () => CrewDetailController(
      getCrewDetailUseCase: sl<GetCrewDetailUseCase>(),
      getCrewAttendanceHistoryUseCase: sl<GetCrewAttendanceHistoryUseCase>(),
    ),
  );
}
