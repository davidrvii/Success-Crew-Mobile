import 'package:get_it/get_it.dart';

import '../../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/domain/usecases/login_usecase.dart';
import '../../../features/auth/domain/usecases/logout_usecase.dart';
import '../../../features/auth/domain/usecases/register_usecase.dart';
import '../../../features/auth/presentation/controllers/login_controller.dart';
import '../../../features/auth/presentation/controllers/register_controller.dart';

import '../../core/network/dio_client.dart';
import '../../core/storage/token_storage.dart';
import '../../core/storage/user_session.dart';

void registerAuthDi(GetIt sl) {
  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      sl<AuthRemoteDataSource>(),
      sl<TokenStorage>(),
      sl<UserSession>(),
    ),
  );

  // UseCases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(sl<AuthRepository>()),
  );

  // Controllers
  sl.registerFactory<LoginController>(
    () => LoginController(loginUseCase: sl<LoginUseCase>()),
  );
  sl.registerFactory<RegisterController>(
    () => RegisterController(registerUseCase: sl<RegisterUseCase>()),
  );
}
