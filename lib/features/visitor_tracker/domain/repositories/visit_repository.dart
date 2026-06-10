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

abstract class VisitRepository {
  // VISIT
  Future<ApiResponse<List<Visit>>> getAdminVisits();
  Future<ApiResponse<Visit>> getVisitDetail(int visitId);
  Future<ApiResponse<Visit>> createVisit(VisitRequest request);
  Future<ApiResponse<Visit>> updateVisit(int visitId, VisitRequest request);
  Future<ApiResponse<int>> deleteVisit(int visitId);
  Future<ApiResponse<List<Visitor>>> getVisitors();

  // FOLLOW-UP
  Future<ApiResponse<List<FollowUp>>> getFollowUps(int visitId);
  Future<ApiResponse<FollowUp>> createFollowUp(
    int visitId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUp>> updateFollowUp(
    int visitId,
    int followUpId,
    FollowUpRequest request,
  );
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
}
