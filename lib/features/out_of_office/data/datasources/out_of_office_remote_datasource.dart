import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/out_of_office_model.dart';
import '../models/out_of_office_request.dart';

abstract class OutOfOfficeRemoteDataSource {
  Future<ApiResponse<OutOfOfficeListResponse>> getOutOfOfficeList(int userId);
  Future<ApiResponse<OutOfOfficeDetailResponse>> getOutOfOfficeDetail(int id);

  Future<ApiResponse<CreateOutOfOfficeResponse>> createOutOfOffice(
    OutOfOfficeRequest request,
  );
  Future<ApiResponse<UpdateOutOfOfficeResponse>> updateOutOfOffice(
    int id,
    OutOfOfficeRequest request,
  );
  Future<ApiResponse<UpdateOutOfOfficeResponse>> updateOutOfOfficeStatus(
    int id,
    String status,
  );
  Future<ApiResponse<DeleteOutOfOfficeResponse>> deleteOutOfOffice(int id);

  Future<ApiResponse<OutOfOfficeListResponse>> getAllOutOfOffice();
  Future<ApiResponse<OutOfOfficeBasicListResponse>> getOutOfOfficeBasicAll();
  Future<ApiResponse<OutOfOfficeBasicDetailResponse>> getOutOfOfficeBasicDetail(int id);
}

class OutOfOfficeRemoteDataSourceImpl implements OutOfOfficeRemoteDataSource {
  final DioClient _client;
  OutOfOfficeRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<OutOfOfficeListResponse>> getOutOfOfficeList(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeCrew(userId)),
      parser: (json) =>
          OutOfOfficeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OutOfOfficeDetailResponse>> getOutOfOfficeDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeDetail(id)),
      parser: (json) =>
          OutOfOfficeDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
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
  Future<ApiResponse<DeleteOutOfOfficeResponse>> deleteOutOfOffice(int id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.outOfOfficeDelete(id)),
      parser: (json) =>
          DeleteOutOfOfficeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OutOfOfficeListResponse>> getAllOutOfOffice() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeAll),
      parser: (json) =>
          OutOfOfficeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OutOfOfficeBasicListResponse>> getOutOfOfficeBasicAll() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeBasicAll),
      parser: (json) =>
          OutOfOfficeBasicListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OutOfOfficeBasicDetailResponse>> getOutOfOfficeBasicDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.outOfOfficeBasicDetail(id)),
      parser: (json) =>
          OutOfOfficeBasicDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
