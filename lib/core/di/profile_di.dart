import 'package:get_it/get_it.dart';

import '../network/dio_client.dart';
import '../storage/user_session.dart';

import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/domain/usecases/get_user_basic.dart';
import '../../features/profile/domain/usecases/get_user_detail.dart';
import '../../features/profile/domain/usecases/update_profile.dart';
import '../../features/profile/presentation/controllers/profile_controller.dart';

void registerProfileDi(GetIt sl) {
  // Data Sources
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repositories
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      sl<ProfileRemoteDataSource>(),
      sl<UserSession>(),
    ),
  );

  // UseCases
  sl.registerLazySingleton<GetUserBasicUseCase>(
    () => GetUserBasicUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton<GetUserDetailUseCase>(
    () => GetUserDetailUseCase(sl<ProfileRepository>()),
  );
  sl.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(sl<ProfileRepository>()),
  );

  // Controllers
  sl.registerFactory<ProfileController>(
    () => ProfileController(
      getUserBasic: sl<GetUserBasicUseCase>(),
      getUserDetail: sl<GetUserDetailUseCase>(),
      updateProfile: sl<UpdateProfileUseCase>(),
      session: sl<UserSession>(),
    ),
  );
}
