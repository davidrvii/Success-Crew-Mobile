import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../config/.env.dart';
import '../network/dio_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/log_interceptor.dart';
import '../storage/token_storage.dart';
import '../storage/user_session.dart';

void registerCoreDi(GetIt sl) {
  // STORAGE (Secure)
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );

  sl.registerLazySingleton<TokenStorage>(
    () => TokenStorageImpl(sl<FlutterSecureStorage>()),
  );

  sl.registerLazySingleton<UserSession>(
    () => UserSession(sl<FlutterSecureStorage>()),
  );

  // NETWORK (Interceptors)
  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(tokenStorage: sl<TokenStorage>()),
  );

  sl.registerLazySingleton<ApiLogInterceptor>(
    () => ApiLogInterceptor(enabled: Env.apiLogs),
  );

  // NETWORK (Dio + Client)
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Env.baseUrl,
        connectTimeout: Env.connectTimeout,
        sendTimeout: Env.sendTimeout,
        receiveTimeout: Env.receiveTimeout,
        headers: const {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    dio.interceptors.add(sl<AuthInterceptor>());

    if (Env.apiLogs) {
      dio.interceptors.add(sl<ApiLogInterceptor>());
    }

    return dio;
  });

  sl.registerLazySingleton<DioClient>(() => DioClient(sl<Dio>()));
}
