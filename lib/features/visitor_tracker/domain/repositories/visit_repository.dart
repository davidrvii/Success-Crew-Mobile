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
  Future<ApiResponse<List<Visit>>> getAllVisits();
  Future<ApiResponse<List<Visit>>> getVisitList();
  Future<ApiResponse<VisitStats>> getVisitStats();
  Future<ApiResponse<Visit>> getVisitDetail(int visitId);
  Future<ApiResponse<Visit>> createVisit(VisitRequest request);
  Future<ApiResponse<Visit>> updateVisit(int visitId, VisitRequest request);
  Future<ApiResponse<int>> deleteVisit(int visitId);
  Future<ApiResponse<List<Visitor>>> getVisitors();
  Future<ApiResponse<Visitor>> getVisitorDetail(int visitorId);
  Future<ApiResponse<Visitor>> createVisitor(VisitorRequest request);
  Future<ApiResponse<Visitor>> updateVisitor(int visitorId, VisitorRequest request);
  Future<ApiResponse<int>> deleteVisitor(int visitorId);

  // FOLLOW-UP
  Future<ApiResponse<List<FollowUp>>> getAllFollowUps();
  Future<ApiResponse<List<FollowUp>>> getFollowUps(int visitId);
  Future<ApiResponse<FollowUp>> addFollowUp(FollowUpRequest request);
  Future<ApiResponse<FollowUp>> createFollowUp(
    int visitId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUp>> updateFollowUpNonNested(
    int followUpId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUp>> updateFollowUp(
    int visitId,
    int followUpId,
    FollowUpRequest request,
  );
  Future<ApiResponse<int>> deleteFollowUpNonNested(int followUpId);
  Future<ApiResponse<int>> deleteFollowUp(int visitId, int followUpId);

  // PRODUCTS SOLD
  Future<ApiResponse<List<ProductSold>>> getProductsSold(int visitId);
  Future<ApiResponse<ProductSold>> createProductSold(
    int visitId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<ProductSold>> updateProductSold(
    int visitId,
    int productSoldId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<int>> deleteProductSold(int visitId, int productSoldId);

  Future<ApiResponse<List<ProductSold>>> getAllProductsSold();
  Future<ApiResponse<ProductSold>> addProductSold(ProductSoldRequest request);
  Future<ApiResponse<ProductSold>> updateProductSoldNonNested(
    int productSoldId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<int>> deleteProductSoldNonNested(int productSoldId);

  // UNITS SERVICED
  Future<ApiResponse<List<UnitServiced>>> getUnitsServiced(int visitId);
  Future<ApiResponse<UnitServiced>> createUnitServiced(
    int visitId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<UnitServiced>> updateUnitServiced(
    int visitId,
    int unitServicedId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<int>> deleteUnitServiced(int visitId, int unitServicedId);

  Future<ApiResponse<List<UnitServiced>>> getAllUnitsServiced();
  Future<ApiResponse<UnitServiced>> addUnitServiced(UnitServicedRequest request);
  Future<ApiResponse<UnitServiced>> updateUnitServicedNonNested(
    int unitServicedId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<int>> deleteUnitServicedNonNested(int unitServicedId);
}
