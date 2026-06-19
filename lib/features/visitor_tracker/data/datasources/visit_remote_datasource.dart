/// File: lib/features/visitor_tracker/data/datasources/visit_remote_datasource.dart
/// Generated Documentation for visit_remote_datasource.dart

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
import '../models/visitor_request.dart';

abstract class VisitRemoteDataSource {
  // VISIT
  /// Method `getAllVisits` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getAllVisits`.
  Future<ApiResponse<VisitListResponse>> getAllVisits();
  /// Method `getVisitList` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getVisitList`.
  Future<ApiResponse<VisitListResponse>> getVisitList();
  /// Method `getVisitStats` returning `Future<ApiResponse<VisitStatsResponse>>`.
  /// Handles logic operations related to `getVisitStats`.
  Future<ApiResponse<VisitStatsResponse>> getVisitStats();
  /// Method `getVisitDetail` returning `Future<ApiResponse<VisitDetailResponse>>`.
  /// Handles logic operations related to `getVisitDetail`.
  Future<ApiResponse<VisitDetailResponse>> getVisitDetail(int visitId);
  /// Method `createVisit` returning `Future<ApiResponse<VisitMutationResponse>>`.
  /// Handles logic operations related to `createVisit`.
  Future<ApiResponse<VisitMutationResponse>> createVisit(VisitRequest request);
  /// Method `updateVisit` returning `Future<ApiResponse<VisitMutationResponse>>`.
  /// Handles logic operations related to `updateVisit`.
  Future<ApiResponse<VisitMutationResponse>> updateVisit(
    int visitId,
    VisitRequest request,
  );
  /// Method `getVisitors` returning `Future<ApiResponse<VisitorListResponse>>`.
  /// Handles logic operations related to `getVisitors`.
  Future<ApiResponse<VisitorListResponse>> getVisitors();
  /// Method `getVisitorDetail` returning `Future<ApiResponse<VisitorDetailResponse>>`.
  /// Handles logic operations related to `getVisitorDetail`.
  Future<ApiResponse<VisitorDetailResponse>> getVisitorDetail(int id);
  /// Method `createVisitor` returning `Future<ApiResponse<VisitorMutationResponse>>`.
  /// Handles logic operations related to `createVisitor`.
  Future<ApiResponse<VisitorMutationResponse>> createVisitor(VisitorRequest request);
  /// Method `updateVisitor` returning `Future<ApiResponse<VisitorMutationResponse>>`.
  /// Handles logic operations related to `updateVisitor`.
  Future<ApiResponse<VisitorMutationResponse>> updateVisitor(
    int visitorId,
    VisitorRequest request,
  );
  /// Method `deleteVisitor` returning `Future<ApiResponse<VisitorDeleteResponse>>`.
  /// Handles logic operations related to `deleteVisitor`.
  Future<ApiResponse<VisitorDeleteResponse>> deleteVisitor(int visitorId);
  /// Method `deleteVisit` returning `Future<ApiResponse<VisitDeleteResponse>>`.
  /// Handles logic operations related to `deleteVisit`.
  Future<ApiResponse<VisitDeleteResponse>> deleteVisit(int visitId);

  // FOLLOW-UP
  /// Method `getAllFollowUps` returning `Future<ApiResponse<FollowUpListResponse>>`.
  /// Handles logic operations related to `getAllFollowUps`.
  Future<ApiResponse<FollowUpListResponse>> getAllFollowUps();
  /// Method `getFollowUps` returning `Future<ApiResponse<FollowUpListResponse>>`.
  /// Handles logic operations related to `getFollowUps`.
  Future<ApiResponse<FollowUpListResponse>> getFollowUps(int visitId);
  /// Method `addFollowUp` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `addFollowUp`.
  Future<ApiResponse<FollowUpMutationResponse>> addFollowUp(
    FollowUpRequest request,
  );
  /// Method `createFollowUp` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `createFollowUp`.
  Future<ApiResponse<FollowUpMutationResponse>> createFollowUp(
    int visitId,
    FollowUpRequest request,
  );
  /// Method `updateFollowUpNonNested` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `updateFollowUpNonNested`.
  Future<ApiResponse<FollowUpMutationResponse>> updateFollowUpNonNested(
    int followUpId,
    FollowUpRequest request,
  );
  /// Method `updateFollowUp` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `updateFollowUp`.
  Future<ApiResponse<FollowUpMutationResponse>> updateFollowUp(
    int visitId,
    int followUpId,
    FollowUpRequest request,
  );
  /// Method `deleteFollowUpNonNested` returning `Future<ApiResponse<FollowUpDeleteResponse>>`.
  /// Handles logic operations related to `deleteFollowUpNonNested`.
  Future<ApiResponse<FollowUpDeleteResponse>> deleteFollowUpNonNested(
    int followUpId,
  );
  /// Method `deleteFollowUp` returning `Future<ApiResponse<FollowUpDeleteResponse>>`.
  /// Handles logic operations related to `deleteFollowUp`.
  Future<ApiResponse<FollowUpDeleteResponse>> deleteFollowUp(
    int visitId,
    int followUpId,
  );

  // PRODUCTS SOLD
  /// Method `getProductsSold` returning `Future<ApiResponse<ProductSoldListResponse>>`.
  /// Handles logic operations related to `getProductsSold`.
  Future<ApiResponse<ProductSoldListResponse>> getProductsSold(int visitId);
  /// Method `createProductSold` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `createProductSold`.
  Future<ApiResponse<ProductSoldMutationResponse>> createProductSold(
    int visitId,
    ProductSoldRequest request,
  );
  /// Method `updateProductSold` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `updateProductSold`.
  Future<ApiResponse<ProductSoldMutationResponse>> updateProductSold(
    int visitId,
    int productSoldId,
    ProductSoldRequest request,
  );
  /// Method `deleteProductSold` returning `Future<ApiResponse<ProductSoldDeleteResponse>>`.
  /// Handles logic operations related to `deleteProductSold`.
  Future<ApiResponse<ProductSoldDeleteResponse>> deleteProductSold(
    int visitId,
    int productSoldId,
  );

  /// Method `getAllProductsSold` returning `Future<ApiResponse<ProductSoldListResponse>>`.
  /// Handles logic operations related to `getAllProductsSold`.
  Future<ApiResponse<ProductSoldListResponse>> getAllProductsSold();
  /// Method `addProductSold` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `addProductSold`.
  Future<ApiResponse<ProductSoldMutationResponse>> addProductSold(
    ProductSoldRequest request,
  );
  /// Method `updateProductSoldNonNested` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `updateProductSoldNonNested`.
  Future<ApiResponse<ProductSoldMutationResponse>> updateProductSoldNonNested(
    int productSoldId,
    ProductSoldRequest request,
  );
  /// Method `deleteProductSoldNonNested` returning `Future<ApiResponse<ProductSoldDeleteResponse>>`.
  /// Handles logic operations related to `deleteProductSoldNonNested`.
  Future<ApiResponse<ProductSoldDeleteResponse>> deleteProductSoldNonNested(
    int productSoldId,
  );

  // UNITS SERVICED
  /// Method `getUnitsServiced` returning `Future<ApiResponse<UnitServicedListResponse>>`.
  /// Handles logic operations related to `getUnitsServiced`.
  Future<ApiResponse<UnitServicedListResponse>> getUnitsServiced(int visitId);
  /// Method `createUnitServiced` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `createUnitServiced`.
  Future<ApiResponse<UnitServicedMutationResponse>> createUnitServiced(
    int visitId,
    UnitServicedRequest request,
  );
  /// Method `updateUnitServiced` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `updateUnitServiced`.
  Future<ApiResponse<UnitServicedMutationResponse>> updateUnitServiced(
    int visitId,
    int unitServicedId,
    UnitServicedRequest request,
  );
  /// Method `deleteUnitServiced` returning `Future<ApiResponse<UnitServicedDeleteResponse>>`.
  /// Handles logic operations related to `deleteUnitServiced`.
  Future<ApiResponse<UnitServicedDeleteResponse>> deleteUnitServiced(
    int visitId,
    int unitServicedId,
  );

  /// Method `getAllUnitsServiced` returning `Future<ApiResponse<UnitServicedListResponse>>`.
  /// Handles logic operations related to `getAllUnitsServiced`.
  Future<ApiResponse<UnitServicedListResponse>> getAllUnitsServiced();
  /// Method `addUnitServiced` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `addUnitServiced`.
  Future<ApiResponse<UnitServicedMutationResponse>> addUnitServiced(
    UnitServicedRequest request,
  );
  /// Method `updateUnitServicedNonNested` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `updateUnitServicedNonNested`.
  Future<ApiResponse<UnitServicedMutationResponse>> updateUnitServicedNonNested(
    int unitServicedId,
    UnitServicedRequest request,
  );
  /// Method `deleteUnitServicedNonNested` returning `Future<ApiResponse<UnitServicedDeleteResponse>>`.
  /// Handles logic operations related to `deleteUnitServicedNonNested`.
  Future<ApiResponse<UnitServicedDeleteResponse>> deleteUnitServicedNonNested(
    int unitServicedId,
  );
}

/// Class representing `VisitRemoteDataSourceImpl`.
/// Auto-generated class documentation.
class VisitRemoteDataSourceImpl implements VisitRemoteDataSource {
  final DioClient _client;
  VisitRemoteDataSourceImpl(this._client);

  // VISIT
  @override
  /// Method `getAllVisits` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getAllVisits`.
  Future<ApiResponse<VisitListResponse>> getAllVisits() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitAll),
      parser: (json) =>
          VisitListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getVisitList` returning `Future<ApiResponse<VisitListResponse>>`.
  /// Handles logic operations related to `getVisitList`.
  Future<ApiResponse<VisitListResponse>> getVisitList() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitList),
      parser: (json) =>
          VisitListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getVisitStats` returning `Future<ApiResponse<VisitStatsResponse>>`.
  /// Handles logic operations related to `getVisitStats`.
  Future<ApiResponse<VisitStatsResponse>> getVisitStats() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitStats),
      parser: (json) =>
          VisitStatsResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getVisitors` returning `Future<ApiResponse<VisitorListResponse>>`.
  /// Handles logic operations related to `getVisitors`.
  Future<ApiResponse<VisitorListResponse>> getVisitors() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitorAll),
      parser: (json) =>
          VisitorListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getVisitorDetail` returning `Future<ApiResponse<VisitorDetailResponse>>`.
  /// Handles logic operations related to `getVisitorDetail`.
  Future<ApiResponse<VisitorDetailResponse>> getVisitorDetail(int id) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitorDetail(id)),
      parser: (json) =>
          VisitorDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createVisitor` returning `Future<ApiResponse<VisitorMutationResponse>>`.
  /// Handles logic operations related to `createVisitor`.
  Future<ApiResponse<VisitorMutationResponse>> createVisitor(
    VisitorRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.visitorAdd, data: request.toJson()),
      parser: (json) =>
          VisitorMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateVisitor` returning `Future<ApiResponse<VisitorMutationResponse>>`.
  /// Handles logic operations related to `updateVisitor`.
  Future<ApiResponse<VisitorMutationResponse>> updateVisitor(
    int visitorId,
    VisitorRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.put(ApiPaths.visitorUpdate(visitorId), data: request.toJson()),
      parser: (json) =>
          VisitorMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteVisitor` returning `Future<ApiResponse<VisitorDeleteResponse>>`.
  /// Handles logic operations related to `deleteVisitor`.
  Future<ApiResponse<VisitorDeleteResponse>> deleteVisitor(int visitorId) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.visitorDelete(visitorId)),
      parser: (json) =>
          VisitorDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getVisitDetail` returning `Future<ApiResponse<VisitDetailResponse>>`.
  /// Handles logic operations related to `getVisitDetail`.
  Future<ApiResponse<VisitDetailResponse>> getVisitDetail(int visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitDetail(visitId)),
      parser: (json) =>
          VisitDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createVisit` returning `Future<ApiResponse<VisitMutationResponse>>`.
  /// Handles logic operations related to `createVisit`.
  Future<ApiResponse<VisitMutationResponse>> createVisit(VisitRequest request) {
    return ApiResponse.guard(
      request: () => _client.post(ApiPaths.visitAdd, data: request.toJson()),
      parser: (json) =>
          VisitMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateVisit` returning `Future<ApiResponse<VisitMutationResponse>>`.
  /// Handles logic operations related to `updateVisit`.
  Future<ApiResponse<VisitMutationResponse>> updateVisit(
    int visitId,
    VisitRequest request,
  ) {
    return ApiResponse.guard(
      request: () =>
          _client.put(ApiPaths.visitUpdate(visitId), data: request.toJson()),
      parser: (json) =>
          VisitMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteVisit` returning `Future<ApiResponse<VisitDeleteResponse>>`.
  /// Handles logic operations related to `deleteVisit`.
  Future<ApiResponse<VisitDeleteResponse>> deleteVisit(int visitId) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.visitDelete(visitId)),
      parser: (json) =>
          VisitDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  // FOLLOW-UP
  @override
  /// Method `getAllFollowUps` returning `Future<ApiResponse<FollowUpListResponse>>`.
  /// Handles logic operations related to `getAllFollowUps`.
  Future<ApiResponse<FollowUpListResponse>> getAllFollowUps() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.followUpAll),
      parser: (json) =>
          FollowUpListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `getFollowUps` returning `Future<ApiResponse<FollowUpListResponse>>`.
  /// Handles logic operations related to `getFollowUps`.
  Future<ApiResponse<FollowUpListResponse>> getFollowUps(int visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitFollowUps(visitId)),
      parser: (json) =>
          FollowUpListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `addFollowUp` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `addFollowUp`.
  Future<ApiResponse<FollowUpMutationResponse>> addFollowUp(
    FollowUpRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(
        ApiPaths.followUpAdd,
        data: request.toJson(),
      ),
      parser: (json) =>
          FollowUpMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createFollowUp` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `createFollowUp`.
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
  /// Method `updateFollowUpNonNested` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `updateFollowUpNonNested`.
  Future<ApiResponse<FollowUpMutationResponse>> updateFollowUpNonNested(
    int followUpId,
    FollowUpRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.put(
        ApiPaths.followUpUpdate(followUpId),
        data: request.toJson(),
      ),
      parser: (json) =>
          FollowUpMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateFollowUp` returning `Future<ApiResponse<FollowUpMutationResponse>>`.
  /// Handles logic operations related to `updateFollowUp`.
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
  /// Method `deleteFollowUpNonNested` returning `Future<ApiResponse<FollowUpDeleteResponse>>`.
  /// Handles logic operations related to `deleteFollowUpNonNested`.
  Future<ApiResponse<FollowUpDeleteResponse>> deleteFollowUpNonNested(
    int followUpId,
  ) {
    return ApiResponse.guard(
      request: () => _client.delete(ApiPaths.followUpDelete(followUpId)),
      parser: (json) =>
          FollowUpDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteFollowUp` returning `Future<ApiResponse<FollowUpDeleteResponse>>`.
  /// Handles logic operations related to `deleteFollowUp`.
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
  /// Method `getProductsSold` returning `Future<ApiResponse<ProductSoldListResponse>>`.
  /// Handles logic operations related to `getProductsSold`.
  Future<ApiResponse<ProductSoldListResponse>> getProductsSold(int visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitProductsSold(visitId)),
      parser: (json) =>
          ProductSoldListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createProductSold` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `createProductSold`.
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
  /// Method `updateProductSold` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `updateProductSold`.
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
  /// Method `deleteProductSold` returning `Future<ApiResponse<ProductSoldDeleteResponse>>`.
  /// Handles logic operations related to `deleteProductSold`.
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

  @override
  /// Method `getAllProductsSold` returning `Future<ApiResponse<ProductSoldListResponse>>`.
  /// Handles logic operations related to `getAllProductsSold`.
  Future<ApiResponse<ProductSoldListResponse>> getAllProductsSold() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.productSoldAll),
      parser: (json) =>
          ProductSoldListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `addProductSold` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `addProductSold`.
  Future<ApiResponse<ProductSoldMutationResponse>> addProductSold(
    ProductSoldRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(
        ApiPaths.productSoldAdd,
        data: request.toJson(),
      ),
      parser: (json) =>
          ProductSoldMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateProductSoldNonNested` returning `Future<ApiResponse<ProductSoldMutationResponse>>`.
  /// Handles logic operations related to `updateProductSoldNonNested`.
  Future<ApiResponse<ProductSoldMutationResponse>> updateProductSoldNonNested(
    int productSoldId,
    ProductSoldRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.put(
        ApiPaths.productSoldUpdate(productSoldId),
        data: request.toJson(),
      ),
      parser: (json) =>
          ProductSoldMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteProductSoldNonNested` returning `Future<ApiResponse<ProductSoldDeleteResponse>>`.
  /// Handles logic operations related to `deleteProductSoldNonNested`.
  Future<ApiResponse<ProductSoldDeleteResponse>> deleteProductSoldNonNested(
    int productSoldId,
  ) {
    return ApiResponse.guard(
      request: () => _client.delete(
        ApiPaths.productSoldDelete(productSoldId),
      ),
      parser: (json) =>
          ProductSoldDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  // UNITS SERVICED
  @override
  /// Method `getUnitsServiced` returning `Future<ApiResponse<UnitServicedListResponse>>`.
  /// Handles logic operations related to `getUnitsServiced`.
  Future<ApiResponse<UnitServicedListResponse>> getUnitsServiced(int visitId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.visitUnitsServiced(visitId)),
      parser: (json) =>
          UnitServicedListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `createUnitServiced` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `createUnitServiced`.
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
  /// Method `updateUnitServiced` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `updateUnitServiced`.
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
  /// Method `deleteUnitServiced` returning `Future<ApiResponse<UnitServicedDeleteResponse>>`.
  /// Handles logic operations related to `deleteUnitServiced`.
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

  @override
  /// Method `getAllUnitsServiced` returning `Future<ApiResponse<UnitServicedListResponse>>`.
  /// Handles logic operations related to `getAllUnitsServiced`.
  Future<ApiResponse<UnitServicedListResponse>> getAllUnitsServiced() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.unitServicedAll),
      parser: (json) =>
          UnitServicedListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `addUnitServiced` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `addUnitServiced`.
  Future<ApiResponse<UnitServicedMutationResponse>> addUnitServiced(
    UnitServicedRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.post(
        ApiPaths.unitServicedAdd,
        data: request.toJson(),
      ),
      parser: (json) =>
          UnitServicedMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `updateUnitServicedNonNested` returning `Future<ApiResponse<UnitServicedMutationResponse>>`.
  /// Handles logic operations related to `updateUnitServicedNonNested`.
  Future<ApiResponse<UnitServicedMutationResponse>> updateUnitServicedNonNested(
    int unitServicedId,
    UnitServicedRequest request,
  ) {
    return ApiResponse.guard(
      request: () => _client.put(
        ApiPaths.unitServicedUpdate(unitServicedId),
        data: request.toJson(),
      ),
      parser: (json) =>
          UnitServicedMutationResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  /// Method `deleteUnitServicedNonNested` returning `Future<ApiResponse<UnitServicedDeleteResponse>>`.
  /// Handles logic operations related to `deleteUnitServicedNonNested`.
  Future<ApiResponse<UnitServicedDeleteResponse>> deleteUnitServicedNonNested(
    int unitServicedId,
  ) {
    return ApiResponse.guard(
      request: () => _client.delete(
        ApiPaths.unitServicedDelete(unitServicedId),
      ),
      parser: (json) =>
          UnitServicedDeleteResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}
