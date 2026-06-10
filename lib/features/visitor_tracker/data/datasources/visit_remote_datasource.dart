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
import '../models/visitor_response.dart';

abstract class VisitRemoteDataSource {
  // VISIT
  Future<ApiResponse<VisitListResponse>> getAdminVisits();
  Future<ApiResponse<VisitDetailResponse>> getVisitDetail(int visitId);
  Future<ApiResponse<VisitMutationResponse>> createVisit(VisitRequest request);
  Future<ApiResponse<VisitMutationResponse>> updateVisit(
    int visitId,
    VisitRequest request,
  );
  Future<ApiResponse<VisitorListResponse>> getVisitors();
  Future<ApiResponse<VisitDeleteResponse>> deleteVisit(int visitId);

  // FOLLOW-UP
  Future<ApiResponse<FollowUpListResponse>> getFollowUps(int visitId);
  Future<ApiResponse<FollowUpMutationResponse>> createFollowUp(
    int visitId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUpMutationResponse>> updateFollowUp(
    int visitId,
    int followUpId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUpDeleteResponse>> deleteFollowUp(
    int visitId,
    int followUpId,
  );

  // PRODUCTS SOLD
  Future<ApiResponse<ProductSoldListResponse>> getProductsSold(int visitId);
  Future<ApiResponse<ProductSoldMutationResponse>> createProductSold(
    int visitId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<ProductSoldMutationResponse>> updateProductSold(
    int visitId,
    int productSoldId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<ProductSoldDeleteResponse>> deleteProductSold(
    int visitId,
    int productSoldId,
  );

  // UNITS SERVICED
  Future<ApiResponse<UnitServicedListResponse>> getUnitsServiced(int visitId);
  Future<ApiResponse<UnitServicedMutationResponse>> createUnitServiced(
    int visitId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<UnitServicedMutationResponse>> updateUnitServiced(
    int visitId,
    int unitServicedId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<UnitServicedDeleteResponse>> deleteUnitServiced(
    int visitId,
    int unitServicedId,
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
  Future<ApiResponse<VisitorListResponse>> getVisitors() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitorAdmin),
      parser: (json) =>
          VisitorListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<VisitDetailResponse>> getVisitDetail(int visitId) {
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
    int visitId,
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
  Future<ApiResponse<VisitDeleteResponse>> deleteVisit(int visitId) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.visitDelete(visitId)),
      parser: (json) =>
          VisitDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  // FOLLOW-UP
  @override
  Future<ApiResponse<FollowUpListResponse>> getFollowUps(int visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitFollowUps(visitId)),
      parser: (json) =>
          FollowUpListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<FollowUpMutationResponse>> createFollowUp(
    int visitId,
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
    int visitId,
    int followUpId,
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
    int visitId,
    int followUpId,
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
  Future<ApiResponse<ProductSoldListResponse>> getProductsSold(int visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitProductsSold(visitId)),
      parser: (json) =>
          ProductSoldListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<ProductSoldMutationResponse>> createProductSold(
    int visitId,
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
    int visitId,
    int productSoldId,
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
    int visitId,
    int productSoldId,
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
  Future<ApiResponse<UnitServicedListResponse>> getUnitsServiced(int visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitUnitsServiced(visitId)),
      parser: (json) =>
          UnitServicedListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UnitServicedMutationResponse>> createUnitServiced(
    int visitId,
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
    int visitId,
    int unitServicedId,
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
    int visitId,
    int unitServicedId,
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
