import 'dart:io';

import 'package:dio/dio.dart';

enum NetworkErrorType {
  cancelled,
  timeout,
  noInternet,
  badCertificate,
  unauthorized,
  forbidden,
  notFound,
  conflict,
  tooManyRequests,
  validation,
  server,
  badRequest,
  unknown,
}

class NetworkException implements Exception {
  final NetworkErrorType type;
  final String message;
  final int? statusCode;
  final dynamic data;

  const NetworkException({
    required this.type,
    required this.message,
    this.statusCode,
    this.data,
  });

  String get userMessage => switch (type) {
    NetworkErrorType.timeout => 'Connection timed out. Please try again.',
    NetworkErrorType.noInternet =>
      'No internet connection. Please check your network.',
    NetworkErrorType.unauthorized =>
      'Your session has expired. Please log in again.',
    NetworkErrorType.forbidden => 'You do not have permission to access this.',
    NetworkErrorType.notFound => 'The requested data was not found.',
    NetworkErrorType.validation => 'The data you submitted is invalid.',
    NetworkErrorType.tooManyRequests =>
      'Too many requests. Please try again later.',
    NetworkErrorType.server =>
      'The server is having issues. Please try again later.',
    NetworkErrorType.badCertificate =>
      'There is a problem with the security certificate.',
    NetworkErrorType.cancelled => 'The request was cancelled.',
    NetworkErrorType.badRequest => 'Invalid request.',
    NetworkErrorType.conflict =>
      'A data conflict occurred. Please refresh and try again.',
    NetworkErrorType.unknown => 'Something went wrong. Please try again.',
  };

  @override
  String toString() =>
      'NetworkException(type: $type, statusCode: $statusCode, message: $message, data: $data)';

  factory NetworkException.fromDioException(DioException e) {
    // Cancel
    if (e.type == DioExceptionType.cancel) {
      return const NetworkException(
        type: NetworkErrorType.cancelled,
        message: 'Request cancelled',
      );
    }

    // Timeout
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return const NetworkException(
        type: NetworkErrorType.timeout,
        message: 'Connection timeout',
      );
    }

    // Bad certificate
    if (e.type == DioExceptionType.badCertificate) {
      return const NetworkException(
        type: NetworkErrorType.badCertificate,
        message: 'Bad certificate',
      );
    }

    // Connection / no internet
    if (e.type == DioExceptionType.connectionError) {
      final err = e.error;
      if (err is SocketException) {
        return const NetworkException(
          type: NetworkErrorType.noInternet,
          message: 'No internet connection',
        );
      }
      return NetworkException(
        type: NetworkErrorType.noInternet,
        message: 'Connection error',
        data: err,
      );
    }

    // Bad response (status code)
    if (e.type == DioExceptionType.badResponse) {
      final res = e.response;
      final status = res?.statusCode;
      final body = res?.data;

      final extractedMessage =
          _extractMessage(body) ?? e.message ?? 'Request failed';

      return _fromStatusCode(
        statusCode: status,
        message: extractedMessage,
        data: body,
      );
    }

    // Unknown fallback
    return NetworkException(
      type: NetworkErrorType.unknown,
      message: e.message ?? 'Unknown error',
      data: e.error,
    );
  }

  static NetworkException _fromStatusCode({
    required int? statusCode,
    required String message,
    dynamic data,
  }) {
    switch (statusCode) {
      case 400:
        return NetworkException(
          type: NetworkErrorType.badRequest,
          statusCode: statusCode,
          message: message,
          data: data,
        );
      case 401:
        return NetworkException(
          type: NetworkErrorType.unauthorized,
          statusCode: statusCode,
          message: message,
          data: data,
        );
      case 403:
        return NetworkException(
          type: NetworkErrorType.forbidden,
          statusCode: statusCode,
          message: message,
          data: data,
        );
      case 404:
        return NetworkException(
          type: NetworkErrorType.notFound,
          statusCode: statusCode,
          message: message,
          data: data,
        );
      case 409:
        return NetworkException(
          type: NetworkErrorType.conflict,
          statusCode: statusCode,
          message: message,
          data: data,
        );
      case 422:
        return NetworkException(
          type: NetworkErrorType.validation,
          statusCode: statusCode,
          message: message,
          data: data,
        );
      case 429:
        return NetworkException(
          type: NetworkErrorType.tooManyRequests,
          statusCode: statusCode,
          message: message,
          data: data,
        );
      default:
        if (statusCode != null && statusCode >= 500) {
          return NetworkException(
            type: NetworkErrorType.server,
            statusCode: statusCode,
            message: message,
            data: data,
          );
        }
        return NetworkException(
          type: NetworkErrorType.unknown,
          statusCode: statusCode,
          message: message,
          data: data,
        );
    }
  }

  static String? _extractMessage(dynamic data) {
    if (data == null) return null;

    if (data is String) return data;

    if (data is Map) {
      final msg = data['message'] ?? data['msg'] ?? data['error'];
      if (msg is String && msg.trim().isNotEmpty) return msg;

      final err = data['error'];
      if (err is Map) {
        final nested = err['message'];
        if (nested is String && nested.trim().isNotEmpty) return nested;
      }
    }

    return null;
  }
}
