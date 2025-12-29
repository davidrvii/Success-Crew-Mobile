import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../config/.env.dart';
import '../network/dio_client.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/log_interceptor.dart';
import '../storage/token_storage.dart';
import '../storage/user_session.dart';

final GetIt sl = GetIt.instance;

Future<void> setupLocator() async {
  _registerCore();
  // _registerFeatures();
}

void _registerCore() {
  // Secure Storage
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(),
      iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
    ),
  );

  // Token + session
  sl.registerLazySingleton<TokenStorage>(() => TokenStorageImpl(sl()));
  sl.registerLazySingleton<UserSession>(() => UserSession(sl()));

  // Interceptors

  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(tokenStorage: sl()),
  );
  sl.registerLazySingleton<ApiLogInterceptor>(
    () => ApiLogInterceptor(enabled: Env.apiLogs),
  );

  // Dio (HTTP Client)
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

  sl.registerLazySingleton<DioClient>(() => DioClient(sl()));
}

Future<void> resetLocator() async {
  await sl.reset();
}
