import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/overtime_model.dart';
import '../models/overtime_request.dart';

abstract class OvertimeRemoteDataSource {
  Future<ApiResponse<OvertimeListResponse>> getOvertimeList(int userId);
  Future<ApiResponse<OvertimeDetailResponse>> getOvertimeDetail(int id);

  Future<ApiResponse<CreateOvertimeResponse>> createOvertime(
    OvertimeRequest request,
  );
  Future<ApiResponse<UpdateOvertimeResponse>> updateOvertime(
    int id,
    OvertimeRequest request,
  );
  Future<ApiResponse<UpdateOvertimeResponse>> updateOvertimeStatus(
    int id,
    String status,
  );
  Future<ApiResponse<DeleteOvertimeResponse>> deleteOvertime(int id);

  Future<ApiResponse<OvertimeListResponse>> getAllOvertime();
  Future<ApiResponse<OvertimeBasicListResponse>> getOvertimeBasicAll();
  Future<ApiResponse<OvertimeBasicDetailResponse>> getOvertimeBasicDetail(int id);
}

class OvertimeRemoteDataSourceImpl implements OvertimeRemoteDataSource {
  final DioClient _client;
  OvertimeRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<OvertimeListResponse>> getOvertimeList(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeCrew(userId)),
      parser: (json) =>
          OvertimeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OvertimeDetailResponse>> getOvertimeDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeDetail(id)),
      parser: (json) =>
          OvertimeDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
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
  Future<ApiResponse<DeleteOvertimeResponse>> deleteOvertime(int id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.overtimeDelete(id)),
      parser: (json) =>
          DeleteOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OvertimeListResponse>> getAllOvertime() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeAll),
      parser: (json) =>
          OvertimeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OvertimeBasicListResponse>> getOvertimeBasicAll() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeBasicAll),
      parser: (json) =>
          OvertimeBasicListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OvertimeBasicDetailResponse>> getOvertimeBasicDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeBasicDetail(id)),
      parser: (json) =>
          OvertimeBasicDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
