import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';

import '../models/visit_request.dart';
import '../models/visit_response.dart';

import '../models/followup_request.dart';
import '../models/followup_response.dart';

import '../models/product_sold_request.dart';
import '../models/product_sold_response.dart';

import '../models/unit_serviced_request.dart';
import '../models/unit_serviced_response.dart';

abstract class VisitRemoteDataSource {
  // VISIT
  Future<ApiResponse<VisitListResponse>> getAdminVisits();
  Future<ApiResponse<VisitDetailResponse>> getVisitDetail(String visitId);
  Future<ApiResponse<VisitMutationResponse>> createVisit(VisitRequest request);
  Future<ApiResponse<VisitMutationResponse>> updateVisit(
    String visitId,
    VisitRequest request,
  );
  Future<ApiResponse<VisitDeleteResponse>> deleteVisit(String visitId);

  // FOLLOW-UP
  Future<ApiResponse<FollowUpListResponse>> getFollowUps(String visitId);
  Future<ApiResponse<FollowUpMutationResponse>> createFollowUp(
    String visitId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUpMutationResponse>> updateFollowUp(
    String visitId,
    String followUpId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUpDeleteResponse>> deleteFollowUp(
    String visitId,
    String followUpId,
  );

  // PRODUCTS SOLD
  Future<ApiResponse<ProductSoldListResponse>> getProductsSold(String visitId);
  Future<ApiResponse<ProductSoldMutationResponse>> createProductSold(
    String visitId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<ProductSoldMutationResponse>> updateProductSold(
    String visitId,
    String productSoldId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<ProductSoldDeleteResponse>> deleteProductSold(
    String visitId,
    String productSoldId,
  );

  // UNITS SERVICED
  Future<ApiResponse<UnitServicedListResponse>> getUnitsServiced(
    String visitId,
  );
  Future<ApiResponse<UnitServicedMutationResponse>> createUnitServiced(
    String visitId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<UnitServicedMutationResponse>> updateUnitServiced(
    String visitId,
    String unitServicedId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<UnitServicedDeleteResponse>> deleteUnitServiced(
    String visitId,
    String unitServicedId,
  );
}

class VisitRemoteDataSourceImpl implements VisitRemoteDataSource {
  final DioClient _client;
  VisitRemoteDataSourceImpl(this._client);

  // VISIT
  @override
  Future<ApiResponse<VisitListResponse>> getAdminVisits() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitAdmin),
      parser: (json) =>
          VisitListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<VisitDetailResponse>> getVisitDetail(String visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitDetail(visitId)),
      parser: (json) =>
          VisitDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<VisitMutationResponse>> createVisit(VisitRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.visitAdd, data: request.toJson()),
      parser: (json) =>
          VisitMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<VisitMutationResponse>> updateVisit(
    String visitId,
    VisitRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.patch(ApiPaths.visitUpdate(visitId), data: request.toJson()),
      parser: (json) =>
          VisitMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<VisitDeleteResponse>> deleteVisit(String visitId) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.visitDelete(visitId)),
      parser: (json) =>
          VisitDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  // FOLLOW-UP
  @override
  Future<ApiResponse<FollowUpListResponse>> getFollowUps(String visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitFollowUps(visitId)),
      parser: (json) =>
          FollowUpListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<FollowUpMutationResponse>> createFollowUp(
    String visitId,
    FollowUpRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(
        ApiPaths.visitFollowUps(visitId),
        data: request.toJson(),
      ),
      parser: (json) =>
          FollowUpMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<FollowUpMutationResponse>> updateFollowUp(
    String visitId,
    String followUpId,
    FollowUpRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.visitFollowUpById(visitId, followUpId),
        data: request.toJson(),
      ),
      parser: (json) =>
          FollowUpMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<FollowUpDeleteResponse>> deleteFollowUp(
    String visitId,
    String followUpId,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.delete(ApiPaths.visitFollowUpById(visitId, followUpId)),
      parser: (json) =>
          FollowUpDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  // PRODUCTS SOLD
  @override
  Future<ApiResponse<ProductSoldListResponse>> getProductsSold(String visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitProductsSold(visitId)),
      parser: (json) =>
          ProductSoldListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<ProductSoldMutationResponse>> createProductSold(
    String visitId,
    ProductSoldRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(
        ApiPaths.visitProductsSold(visitId),
        data: request.toJson(),
      ),
      parser: (json) =>
          ProductSoldMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<ProductSoldMutationResponse>> updateProductSold(
    String visitId,
    String productSoldId,
    ProductSoldRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.visitProductSoldById(visitId, productSoldId),
        data: request.toJson(),
      ),
      parser: (json) =>
          ProductSoldMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<ProductSoldDeleteResponse>> deleteProductSold(
    String visitId,
    String productSoldId,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.delete(ApiPaths.visitProductSoldById(visitId, productSoldId)),
      parser: (json) =>
          ProductSoldDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  // UNITS SERVICED
  @override
  Future<ApiResponse<UnitServicedListResponse>> getUnitsServiced(
    String visitId,
  ) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitUnitsServiced(visitId)),
      parser: (json) =>
          UnitServicedListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UnitServicedMutationResponse>> createUnitServiced(
    String visitId,
    UnitServicedRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(
        ApiPaths.visitUnitsServiced(visitId),
        data: request.toJson(),
      ),
      parser: (json) =>
          UnitServicedMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UnitServicedMutationResponse>> updateUnitServiced(
    String visitId,
    String unitServicedId,
    UnitServicedRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.patch(
        ApiPaths.visitUnitServicedById(visitId, unitServicedId),
        data: request.toJson(),
      ),
      parser: (json) =>
          UnitServicedMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UnitServicedDeleteResponse>> deleteUnitServiced(
    String visitId,
    String unitServicedId,
  ) {
    return ApiResponse.guard(
      request: () => _client.delete(
        ApiPaths.visitUnitServicedById(visitId, unitServicedId),
      ),
      parser: (json) =>
          UnitServicedDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
