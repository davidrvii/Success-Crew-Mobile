import 'package:dio/dio.dart';

import 'network_exceptions.dart';

class ApiResponse<T> {
  final T? data;
  final NetworkException? error;

  const ApiResponse._({this.data, this.error});

  bool get isSuccess => error == null;
  bool get isFailure => error != null;

  factory ApiResponse.success(T data) => ApiResponse._(data: data);
  factory ApiResponse.failure(NetworkException error) =>
      ApiResponse._(error: error);

  static Future<ApiResponse<R>> guard<R>({
    required Future<Response<dynamic>> Function() request,
    required R Function(dynamic json) parser,
  }) async {
    try {
      final res = await request();
      final parsed = parser(res.data);
      return ApiResponse.success(parsed);
    } on DioException catch (e) {
      return ApiResponse.failure(NetworkException.fromDioException(e));
    } catch (e) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: e.toString(),
          data: e,
        ),
      );
    }
  }

  ApiResponse<R> map<R>(R Function(T data) transform) {
    if (isFailure) return ApiResponse.failure(error!);
    return ApiResponse.success(transform(data as T));
  }
}
