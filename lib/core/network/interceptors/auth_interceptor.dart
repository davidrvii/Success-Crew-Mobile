import 'package:dio/dio.dart';

import '../../config/.env.dart';
import '../../storage/token_storage.dart';
import '../../storage/user_session.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage tokenStorage;
  final UserSession? userSession;

  AuthInterceptor({required this.tokenStorage, this.userSession});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = await tokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers[Env.authHeaderKey] = '${Env.bearerPrefix}$token';
      }
    } catch (_) {}

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final status = err.response?.statusCode;

    if (status == 401 || status == 403) {
      try {
        await tokenStorage.clear();
        await userSession?.clear();
      } catch (_) {}
    }

    handler.next(err);
  }
}
