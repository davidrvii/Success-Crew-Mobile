import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/overtime_model.dart';
import '../models/overtime_request.dart';

abstract class OvertimeRemoteDataSource {
  Future<ApiResponse<OvertimeListResponse>> getOvertimeList(String userId);
  Future<ApiResponse<OvertimeDetailResponse>> getOvertimeDetail(String id);

  Future<ApiResponse<CreateOvertimeResponse>> createOvertime(
    OvertimeRequest request,
  );
  Future<ApiResponse<UpdateOvertimeResponse>> updateOvertime(
    String id,
    OvertimeRequest request,
  );
  Future<ApiResponse<DeleteOvertimeResponse>> deleteOvertime(String id);

  Future<ApiResponse<OvertimeListResponse>> getAllOvertimeAdmin();
}

class OvertimeRemoteDataSourceImpl implements OvertimeRemoteDataSource {
  final DioClient _client;
  OvertimeRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<OvertimeListResponse>> getOvertimeList(String userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeCrew(userId)),
      parser: (json) =>
          OvertimeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OvertimeDetailResponse>> getOvertimeDetail(String id) {
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
    String id,
    OvertimeRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.patch(ApiPaths.overtimeUpdate(id), data: request.toJson()),
      parser: (json) =>
          UpdateOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<DeleteOvertimeResponse>> deleteOvertime(String id) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.overtimeDelete(id)),
      parser: (json) =>
          DeleteOvertimeResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<OvertimeListResponse>> getAllOvertimeAdmin() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.overtimeAdmin),
      parser: (json) =>
          OvertimeListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
