/// File: lib/features/visitor_tracker/domain/repositories/visit_repository.dart
/// Generated Documentation for visit_repository.dart

import '../../../../core/network/api_response.dart';

import '../../data/models/visit_request.dart';
import '../../data/models/followup_request.dart';
import '../../data/models/product_sold_request.dart';
import '../../data/models/unit_serviced_request.dart';

import '../entities/visit.dart';
import '../entities/followup.dart';
import '../entities/product_sold.dart';
import '../entities/unit_serviced.dart';
import '../entities/visitor.dart';

import '../../data/models/visitor_request.dart';
import '../entities/visit_stats.dart';

abstract class VisitRepository {
  // VISIT
  /// Method `getAllVisits` returning `Future<ApiResponse<List<Visit>>>`.
  /// Handles logic operations related to `getAllVisits`.
  Future<ApiResponse<List<Visit>>> getAllVisits();
  /// Method `getVisitList` returning `Future<ApiResponse<List<Visit>>>`.
  /// Handles logic operations related to `getVisitList`.
  Future<ApiResponse<List<Visit>>> getVisitList();
  /// Method `getVisitStats` returning `Future<ApiResponse<VisitStats>>`.
  /// Handles logic operations related to `getVisitStats`.
  Future<ApiResponse<VisitStats>> getVisitStats({String? location});
  /// Method `getVisitDetail` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `getVisitDetail`.
  Future<ApiResponse<Visit>> getVisitDetail(int visitId);
  /// Method `createVisit` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `createVisit`.
  Future<ApiResponse<Visit>> createVisit(VisitRequest request);
  /// Method `updateVisit` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `updateVisit`.
  Future<ApiResponse<Visit>> updateVisit(int visitId, VisitRequest request);
  /// Method `deleteVisit` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteVisit`.
  Future<ApiResponse<int>> deleteVisit(int visitId);
  /// Method `getVisitors` returning `Future<ApiResponse<List<Visitor>>>`.
  /// Handles logic operations related to `getVisitors`.
  Future<ApiResponse<List<Visitor>>> getVisitors();
  /// Method `getVisitorDetail` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `getVisitorDetail`.
  Future<ApiResponse<Visitor>> getVisitorDetail(int visitorId);
  /// Method `createVisitor` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `createVisitor`.
  Future<ApiResponse<Visitor>> createVisitor(VisitorRequest request);
  /// Method `updateVisitor` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `updateVisitor`.
  Future<ApiResponse<Visitor>> updateVisitor(int visitorId, VisitorRequest request);
  /// Method `deleteVisitor` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteVisitor`.
  Future<ApiResponse<int>> deleteVisitor(int visitorId);

  // FOLLOW-UP
  /// Method `getAllFollowUps` returning `Future<ApiResponse<List<FollowUp>>>`.
  /// Handles logic operations related to `getAllFollowUps`.
  Future<ApiResponse<List<FollowUp>>> getAllFollowUps();
  /// Method `getFollowUps` returning `Future<ApiResponse<List<FollowUp>>>`.
  /// Handles logic operations related to `getFollowUps`.
  Future<ApiResponse<List<FollowUp>>> getFollowUps(int visitId);
  /// Method `addFollowUp` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `addFollowUp`.
  Future<ApiResponse<FollowUp>> addFollowUp(FollowUpRequest request);
  /// Method `createFollowUp` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `createFollowUp`.
  Future<ApiResponse<FollowUp>> createFollowUp(
    int visitId,
    FollowUpRequest request,
  );
  /// Method `updateFollowUpNonNested` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `updateFollowUpNonNested`.
  Future<ApiResponse<FollowUp>> updateFollowUpNonNested(
    int followUpId,
    FollowUpRequest request,
  );
  /// Method `updateFollowUp` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `updateFollowUp`.
  Future<ApiResponse<FollowUp>> updateFollowUp(
    int visitId,
    int followUpId,
    FollowUpRequest request,
  );
  /// Method `deleteFollowUpNonNested` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteFollowUpNonNested`.
  Future<ApiResponse<int>> deleteFollowUpNonNested(int followUpId);
  /// Method `deleteFollowUp` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteFollowUp`.
  Future<ApiResponse<int>> deleteFollowUp(int visitId, int followUpId);

  // PRODUCTS SOLD
  /// Method `getProductsSold` returning `Future<ApiResponse<List<ProductSold>>>`.
  /// Handles logic operations related to `getProductsSold`.
  Future<ApiResponse<List<ProductSold>>> getProductsSold(int visitId);
  /// Method `createProductSold` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `createProductSold`.
  Future<ApiResponse<ProductSold>> createProductSold(
    int visitId,
    ProductSoldRequest request,
  );
  /// Method `updateProductSold` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `updateProductSold`.
  Future<ApiResponse<ProductSold>> updateProductSold(
    int visitId,
    int productSoldId,
    ProductSoldRequest request,
  );
  /// Method `deleteProductSold` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteProductSold`.
  Future<ApiResponse<int>> deleteProductSold(int visitId, int productSoldId);

  /// Method `getAllProductsSold` returning `Future<ApiResponse<List<ProductSold>>>`.
  /// Handles logic operations related to `getAllProductsSold`.
  Future<ApiResponse<List<ProductSold>>> getAllProductsSold();
  /// Method `addProductSold` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `addProductSold`.
  Future<ApiResponse<ProductSold>> addProductSold(ProductSoldRequest request);
  /// Method `updateProductSoldNonNested` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `updateProductSoldNonNested`.
  Future<ApiResponse<ProductSold>> updateProductSoldNonNested(
    int productSoldId,
    ProductSoldRequest request,
  );
  /// Method `deleteProductSoldNonNested` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteProductSoldNonNested`.
  Future<ApiResponse<int>> deleteProductSoldNonNested(int productSoldId);

  // UNITS SERVICED
  /// Method `getUnitsServiced` returning `Future<ApiResponse<List<UnitServiced>>>`.
  /// Handles logic operations related to `getUnitsServiced`.
  Future<ApiResponse<List<UnitServiced>>> getUnitsServiced(int visitId);
  /// Method `createUnitServiced` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `createUnitServiced`.
  Future<ApiResponse<UnitServiced>> createUnitServiced(
    int visitId,
    UnitServicedRequest request,
  );
  /// Method `updateUnitServiced` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `updateUnitServiced`.
  Future<ApiResponse<UnitServiced>> updateUnitServiced(
    int visitId,
    int unitServicedId,
    UnitServicedRequest request,
  );
  /// Method `deleteUnitServiced` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteUnitServiced`.
  Future<ApiResponse<int>> deleteUnitServiced(int visitId, int unitServicedId);

  /// Method `getAllUnitsServiced` returning `Future<ApiResponse<List<UnitServiced>>>`.
  /// Handles logic operations related to `getAllUnitsServiced`.
  Future<ApiResponse<List<UnitServiced>>> getAllUnitsServiced();
  /// Method `addUnitServiced` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `addUnitServiced`.
  Future<ApiResponse<UnitServiced>> addUnitServiced(UnitServicedRequest request);
  /// Method `updateUnitServicedNonNested` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `updateUnitServicedNonNested`.
  Future<ApiResponse<UnitServiced>> updateUnitServicedNonNested(
    int unitServicedId,
    UnitServicedRequest request,
  );
  /// Method `deleteUnitServicedNonNested` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteUnitServicedNonNested`.
  Future<ApiResponse<int>> deleteUnitServicedNonNested(int unitServicedId);
}
