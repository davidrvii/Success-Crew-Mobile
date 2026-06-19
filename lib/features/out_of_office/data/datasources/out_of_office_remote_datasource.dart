/// File: lib/features/out_of_office/data/datasources/out_of_office_remote_datasource.dart
/// Generated Documentation for out_of_office_remote_datasource.dart

import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/out_of_office_model.dart';
import '../models/out_of_office_request.dart';

abstract class OutOfOfficeRemoteDataSource {
  /// Method `getOutOfOfficeList` returning `Future<ApiResponse<OutOfOfficeListResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeList`.
  Future<ApiResponse<OutOfOfficeListResponse>> getOutOfOfficeList(int userId);
  /// Method `getOutOfOfficeDetail` returning `Future<ApiResponse<OutOfOfficeDetailResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeDetail`.
  Future<ApiResponse<OutOfOfficeDetailResponse>> getOutOfOfficeDetail(int id);

  /// Method `createOutOfOffice` returning `Future<ApiResponse<CreateOutOfOfficeResponse>>`.
  /// Handles logic operations related to `createOutOfOffice`.
  Future<ApiResponse<CreateOutOfOfficeResponse>> createOutOfOffice(
    OutOfOfficeRequest request,
  );
  /// Method `updateOutOfOffice` returning `Future<ApiResponse<UpdateOutOfOfficeResponse>>`.
  /// Handles logic operations related to `updateOutOfOffice`.
  Future<ApiResponse<UpdateOutOfOfficeResponse>> updateOutOfOffice(
    int id,
    OutOfOfficeRequest request,
  );
  /// Method `updateOutOfOfficeStatus` returning `Future<ApiResponse<UpdateOutOfOfficeResponse>>`.
  /// Handles logic operations related to `updateOutOfOfficeStatus`.
  Future<ApiResponse<UpdateOutOfOfficeResponse>> updateOutOfOfficeStatus(
    int id,
    String status,
  );
  /// Method `deleteOutOfOffice` returning `Future<ApiResponse<DeleteOutOfOfficeResponse>>`.
  /// Handles logic operations related to `deleteOutOfOffice`.
  Future<ApiResponse<DeleteOutOfOfficeResponse>> deleteOutOfOffice(int id);

  /// Method `getAllOutOfOffice` returning `Future<ApiResponse<OutOfOfficeListResponse>>`.
  /// Handles logic operations related to `getAllOutOfOffice`.
  Future<ApiResponse<OutOfOfficeListResponse>> getAllOutOfOffice();
  /// Method `getOutOfOfficeBasicAll` returning `Future<ApiResponse<OutOfOfficeBasicListResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeBasicAll`.
  Future<ApiResponse<OutOfOfficeBasicListResponse>> getOutOfOfficeBasicAll();
  /// Method `getOutOfOfficeBasicDetail` returning `Future<ApiResponse<OutOfOfficeBasicDetailResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeBasicDetail`.
  Future<ApiResponse<OutOfOfficeBasicDetailResponse>> getOutOfOfficeBasicDetail(int id);
}

/// Class representing `OutOfOfficeRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class OutOfOfficeRemoteDataSourceImpl implements OutOfOfficeRemoteDataSource {
  final DioClient _client;
  OutOfOfficeRemoteDataSourceImpl(this._client);

  @override
  /// Method `getOutOfOfficeList` returning `Future<ApiResponse<OutOfOfficeListResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeList`.
  Future<ApiResponse<OutOfOfficeListResponse>> getOutOfOfficeList(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeCrew(userId)),
      parser: (json) =>
          OutOfOfficeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getOutOfOfficeDetail` returning `Future<ApiResponse<OutOfOfficeDetailResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeDetail`.
  Future<ApiResponse<OutOfOfficeDetailResponse>> getOutOfOfficeDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeDetail(id)),
      parser: (json) =>
          OutOfOfficeDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createOutOfOffice` returning `Future<ApiResponse<CreateOutOfOfficeResponse>>`.
  /// Handles logic operations related to `createOutOfOffice`.
  Future<ApiResponse<CreateOutOfOfficeResponse>> createOutOfOffice(
    OutOfOfficeRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.outOfOfficeAdd, data: request.toJson()),
      parser: (json) =>
          CreateOutOfOfficeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateOutOfOffice` returning `Future<ApiResponse<UpdateOutOfOfficeResponse>>`.
  /// Handles logic operations related to `updateOutOfOffice`.
  Future<ApiResponse<UpdateOutOfOfficeResponse>> updateOutOfOffice(
    int id,
    OutOfOfficeRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.put(ApiPaths.outOfOfficeUpdatePut(id), data: request.toJson()),
      parser: (json) =>
          UpdateOutOfOfficeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateOutOfOfficeStatus` returning `Future<ApiResponse<UpdateOutOfOfficeResponse>>`.
  /// Handles logic operations related to `updateOutOfOfficeStatus`.
  Future<ApiResponse<UpdateOutOfOfficeResponse>> updateOutOfOfficeStatus(
    int id,
    String status,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.outOfOfficeUpdatePatch(id),
        data: {'out_of_office_status': status},
      ),
      parser: (json) =>
          UpdateOutOfOfficeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteOutOfOffice` returning `Future<ApiResponse<DeleteOutOfOfficeResponse>>`.
  /// Handles logic operations related to `deleteOutOfOffice`.
  Future<ApiResponse<DeleteOutOfOfficeResponse>> deleteOutOfOffice(int id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.outOfOfficeDelete(id)),
      parser: (json) =>
          DeleteOutOfOfficeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getAllOutOfOffice` returning `Future<ApiResponse<OutOfOfficeListResponse>>`.
  /// Handles logic operations related to `getAllOutOfOffice`.
  Future<ApiResponse<OutOfOfficeListResponse>> getAllOutOfOffice() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeAll),
      parser: (json) =>
          OutOfOfficeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getOutOfOfficeBasicAll` returning `Future<ApiResponse<OutOfOfficeBasicListResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeBasicAll`.
  Future<ApiResponse<OutOfOfficeBasicListResponse>> getOutOfOfficeBasicAll() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeBasicAll),
      parser: (json) =>
          OutOfOfficeBasicListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getOutOfOfficeBasicDetail` returning `Future<ApiResponse<OutOfOfficeBasicDetailResponse>>`.
  /// Handles logic operations related to `getOutOfOfficeBasicDetail`.
  Future<ApiResponse<OutOfOfficeBasicDetailResponse>> getOutOfOfficeBasicDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeBasicDetail(id)),
      parser: (json) =>
          OutOfOfficeBasicDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
