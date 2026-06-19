/// File: lib/features/overtime/data/datasources/overtime_remote_datasource.dart
/// Generated Documentation for overtime_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/overtime_model.dart';
import '../models/overtime_request.dart';

abstract class OvertimeRemoteDataSource {
  /// Method `getOvertimeList` returning `Future<ApiResponse<OvertimeListResponse>>`.
  /// Handles logic operations related to `getOvertimeList`.
  Future<ApiResponse<OvertimeListResponse>> getOvertimeList(int userId);
  /// Method `getOvertimeDetail` returning `Future<ApiResponse<OvertimeDetailResponse>>`.
  /// Handles logic operations related to `getOvertimeDetail`.
  Future<ApiResponse<OvertimeDetailResponse>> getOvertimeDetail(int id);

  /// Method `createOvertime` returning `Future<ApiResponse<CreateOvertimeResponse>>`.
  /// Handles logic operations related to `createOvertime`.
  Future<ApiResponse<CreateOvertimeResponse>> createOvertime(
    OvertimeRequest request,
  );
  /// Method `updateOvertime` returning `Future<ApiResponse<UpdateOvertimeResponse>>`.
  /// Handles logic operations related to `updateOvertime`.
  Future<ApiResponse<UpdateOvertimeResponse>> updateOvertime(
    int id,
    OvertimeRequest request,
  );
  /// Method `updateOvertimeStatus` returning `Future<ApiResponse<UpdateOvertimeResponse>>`.
  /// Handles logic operations related to `updateOvertimeStatus`.
  Future<ApiResponse<UpdateOvertimeResponse>> updateOvertimeStatus(
    int id,
    String status,
  );
  /// Method `deleteOvertime` returning `Future<ApiResponse<DeleteOvertimeResponse>>`.
  /// Handles logic operations related to `deleteOvertime`.
  Future<ApiResponse<DeleteOvertimeResponse>> deleteOvertime(int id);

  /// Method `getAllOvertime` returning `Future<ApiResponse<OvertimeListResponse>>`.
  /// Handles logic operations related to `getAllOvertime`.
  Future<ApiResponse<OvertimeListResponse>> getAllOvertime();
  /// Method `getOvertimeBasicAll` returning `Future<ApiResponse<OvertimeBasicListResponse>>`.
  /// Handles logic operations related to `getOvertimeBasicAll`.
  Future<ApiResponse<OvertimeBasicListResponse>> getOvertimeBasicAll();
  /// Method `getOvertimeBasicDetail` returning `Future<ApiResponse<OvertimeBasicDetailResponse>>`.
  /// Handles logic operations related to `getOvertimeBasicDetail`.
  Future<ApiResponse<OvertimeBasicDetailResponse>> getOvertimeBasicDetail(int id);
}

/// Class representing `OvertimeRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class OvertimeRemoteDataSourceImpl implements OvertimeRemoteDataSource {
  final DioClient _client;
  OvertimeRemoteDataSourceImpl(this._client);

  @override
  /// Method `getOvertimeList` returning `Future<ApiResponse<OvertimeListResponse>>`.
  /// Handles logic operations related to `getOvertimeList`.
  Future<ApiResponse<OvertimeListResponse>> getOvertimeList(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeCrew(userId)),
      parser: (json) =>
          OvertimeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getOvertimeDetail` returning `Future<ApiResponse<OvertimeDetailResponse>>`.
  /// Handles logic operations related to `getOvertimeDetail`.
  Future<ApiResponse<OvertimeDetailResponse>> getOvertimeDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeDetail(id)),
      parser: (json) =>
          OvertimeDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createOvertime` returning `Future<ApiResponse<CreateOvertimeResponse>>`.
  /// Handles logic operations related to `createOvertime`.
  Future<ApiResponse<CreateOvertimeResponse>> createOvertime(
    OvertimeRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.overtimeAdd, data: request.toJson()),
      parser: (json) =>
          CreateOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateOvertime` returning `Future<ApiResponse<UpdateOvertimeResponse>>`.
  /// Handles logic operations related to `updateOvertime`.
  Future<ApiResponse<UpdateOvertimeResponse>> updateOvertime(
    int id,
    OvertimeRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.put(ApiPaths.overtimeUpdate(id), data: request.toJson()),
      parser: (json) =>
          UpdateOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateOvertimeStatus` returning `Future<ApiResponse<UpdateOvertimeResponse>>`.
  /// Handles logic operations related to `updateOvertimeStatus`.
  Future<ApiResponse<UpdateOvertimeResponse>> updateOvertimeStatus(
    int id,
    String status,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.overtimeUpdate(id),
        data: {'overtime_status': status},
      ),
      parser: (json) =>
          UpdateOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteOvertime` returning `Future<ApiResponse<DeleteOvertimeResponse>>`.
  /// Handles logic operations related to `deleteOvertime`.
  Future<ApiResponse<DeleteOvertimeResponse>> deleteOvertime(int id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.overtimeDelete(id)),
      parser: (json) =>
          DeleteOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getAllOvertime` returning `Future<ApiResponse<OvertimeListResponse>>`.
  /// Handles logic operations related to `getAllOvertime`.
  Future<ApiResponse<OvertimeListResponse>> getAllOvertime() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeAll),
      parser: (json) =>
          OvertimeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getOvertimeBasicAll` returning `Future<ApiResponse<OvertimeBasicListResponse>>`.
  /// Handles logic operations related to `getOvertimeBasicAll`.
  Future<ApiResponse<OvertimeBasicListResponse>> getOvertimeBasicAll() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeBasicAll),
      parser: (json) =>
          OvertimeBasicListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getOvertimeBasicDetail` returning `Future<ApiResponse<OvertimeBasicDetailResponse>>`.
  /// Handles logic operations related to `getOvertimeBasicDetail`.
  Future<ApiResponse<OvertimeBasicDetailResponse>> getOvertimeBasicDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeBasicDetail(id)),
      parser: (json) =>
          OvertimeBasicDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
