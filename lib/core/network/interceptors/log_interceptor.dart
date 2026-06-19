/// File: lib/core/network/interceptors/log_interceptor.dart
/// Generated Documentation for log_interceptor.dart

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Class representing `ApiLogInterceptor`.
/// Auto-generated class documentation.
class ApiLogInterceptor extends Interceptor {
  final bool enabled;

  ApiLogInterceptor({required this.enabled});

  /// Method `_log` returning `void`.
  /// Handles logic operations related to `_log`.
  void _log(String message) {
    if (!enabled) return;
    if (kDebugMode) {
      debugPrint(message);
    }
  }

  @override
  /// Method `onRequest` returning `void`.
  /// Handles logic operations related to `onRequest`.
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _log('┌───────────────────────────────');
    _log('│ [REQ] ${options.method} ${options.baseUrl}${options.path}');
    if (options.headers.isNotEmpty) _log('│ Headers: ${options.headers}');
    if (options.queryParameters.isNotEmpty) {
      _log('│ Query: ${options.queryParameters}');
    }
    if (options.data != null) _log('│ Body: ${options.data}');
    _log('└───────────────────────────────');

    handler.next(options);
  }

  @override
  /// Method `onResponse` returning `void`.
  /// Handles logic operations related to `onResponse`.
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _log('┌───────────────────────────────');
    _log(
      '│ [RES] ${response.statusCode} ${response.requestOptions.method} ${response.requestOptions.path}',
    );
    _log('│ Data: ${response.data}');
    _log('└───────────────────────────────');

    handler.next(response);
  }

  @override
  /// Method `onError` returning `void`.
  /// Handles logic operations related to `onError`.
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _log('┌───────────────────────────────');
    _log(
      '│ [ERR] ${err.type} ${err.requestOptions.method} ${err.requestOptions.path}',
    );
    _log('│ Message: ${err.message}');
    if (err.response != null) {
      _log('│ Status: ${err.response?.statusCode}');
      _log('│ Data: ${err.response?.data}');
    }
    _log('└───────────────────────────────');

    handler.next(err);
  }
}
