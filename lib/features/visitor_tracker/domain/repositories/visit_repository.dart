import '../../../../core/network/api_response.dart';

import '../../data/models/visit_request.dart';
import '../../data/models/followup_request.dart';
import '../../data/models/product_sold_request.dart';
import '../../data/models/unit_serviced_request.dart';

import '../entities/visit.dart';
import '../entities/followup.dart';
import '../entities/product_sold.dart';
import '../entities/unit_serviced.dart';

abstract class VisitRepository {
  // VISIT
  Future<ApiResponse<List<Visit>>> getAdminVisits();
  Future<ApiResponse<Visit>> getVisitDetail(String visitId);
  Future<ApiResponse<Visit>> createVisit(VisitRequest request);
  Future<ApiResponse<Visit>> updateVisit(String visitId, VisitRequest request);
  Future<ApiResponse<int>> deleteVisit(String visitId);

  // FOLLOW-UP
  Future<ApiResponse<List<FollowUp>>> getFollowUps(String visitId);
  Future<ApiResponse<FollowUp>> createFollowUp(
    String visitId,
    FollowUpRequest request,
  );
  Future<ApiResponse<FollowUp>> updateFollowUp(
    String visitId,
    String followUpId,
    FollowUpRequest request,
  );
  Future<ApiResponse<int>> deleteFollowUp(String visitId, String followUpId);

  // PRODUCTS SOLD
  Future<ApiResponse<List<ProductSold>>> getProductsSold(String visitId);
  Future<ApiResponse<ProductSold>> createProductSold(
    String visitId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<ProductSold>> updateProductSold(
    String visitId,
    String productSoldId,
    ProductSoldRequest request,
  );
  Future<ApiResponse<int>> deleteProductSold(
    String visitId,
    String productSoldId,
  );

  // UNITS SERVICED
  Future<ApiResponse<List<UnitServiced>>> getUnitsServiced(String visitId);
  Future<ApiResponse<UnitServiced>> createUnitServiced(
    String visitId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<UnitServiced>> updateUnitServiced(
    String visitId,
    String unitServicedId,
    UnitServicedRequest request,
  );
  Future<ApiResponse<int>> deleteUnitServiced(
    String visitId,
    String unitServicedId,
  );
}
