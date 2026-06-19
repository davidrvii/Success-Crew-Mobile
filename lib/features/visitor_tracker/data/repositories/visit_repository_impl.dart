/// File: lib/features/visitor_tracker/data/repositories/visit_repository_impl.dart
/// Generated Documentation for visit_repository_impl.dart

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';

import '../../domain/entities/visit.dart';
import '../../domain/entities/followup.dart';
import '../../domain/entities/product_sold.dart';
import '../../domain/entities/unit_serviced.dart';
import '../../domain/entities/visit_stats.dart';
import '../../domain/repositories/visit_repository.dart';

import '../datasources/visit_remote_datasource.dart';

import '../models/visit_model.dart';
import '../models/followup_model.dart';
import '../models/product_sold_model.dart';
import '../models/unit_serviced_model.dart';
import '../models/visit_stats_model.dart';
import '../../domain/entities/visitor.dart';
import '../models/visitor_model.dart';
import '../models/visitor_request.dart';

import '../models/visit_request.dart';
import '../models/followup_request.dart';
import '../models/product_sold_request.dart';
import '../models/unit_serviced_request.dart';

/// Class representing `VisitRepositoryImpl`.
/// Auto-generated class documentation.
class VisitRepositoryImpl implements VisitRepository {
  final VisitRemoteDataSource _remote;
  const VisitRepositoryImpl(this._remote);

  // ---------- MAPPERS ----------
  /// Method `_requireInt` returning `int`.
  /// Handles logic operations related to `_requireInt`.
  int _requireInt(int? v, String field) {
    if (v == null) {
      throw NetworkException(
        type: NetworkErrorType.unknown,
        message: 'Unexpected response: $field is null',
      );
    }
    return v;
  }

  Visit _mapVisit(VisitModel m) => Visit(
    visitId: m.visitId,
    visitorId: m.visitorId,
    userId: m.userId,
    visitor: m.visitor,
    visitorName: m.visitorName ?? m.visitor?.visitorName,
    visitorPhone: m.visitorPhone ?? m.visitor?.visitorPhone,
    visitorCompany: m.visitorCompany ?? m.visitor?.visitorCompany,
    visitorCategory: m.visitorCategory ?? m.visitor?.visitorCategory,
    visitorInterest: m.visitorInterest,
    visitorStatus: m.visitorStatus,
    visitType: m.visitType,
    visitDesc: m.visitDesc,
    visitSales: m.visitSales,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
    followUps: m.followUps?.map((f) => _mapFollowUp(f, m.visitId)).toList(),
    productsSold:
        m.productsSold?.map((p) => _mapProductSold(p, m.visitId)).toList(),
    unitsServiced:
        m.unitsServiced?.map((u) => _mapUnitServiced(u, m.visitId)).toList(),
  );

  Visitor _mapVisitor(VisitorModel m) => Visitor(
    visitorId: m.visitorId,
    visitorName: m.visitorName,
    visitorPhone: m.visitorPhone,
    visitorCompany: m.visitorCompany,
    visitorCategory: m.visitorCategory,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
    visits: m.visitsModel?.map(_mapVisit).toList(),
  );

  FollowUp _mapFollowUp(FollowUpModel m, [int? parentVisitId]) => FollowUp(
    followUpId: m.followUpId,
    visitId: m.visitId ?? parentVisitId,
    followUpStatus: m.followUpStatus,
    followUpAction: m.followUpAction,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  ProductSold _mapProductSold(
    ProductSoldModel m, [
    int? parentVisitId,
  ]) => ProductSold(
    productSoldId: m.productSoldId,
    visitId:
        m.visitId ??
        parentVisitId ??
        _requireInt(m.visitId, 'productSold.visitId'),
    productName: m.productName,
    quantity: m.quantity,
    price: m.price,
    total: m.total,
    notes: m.notes,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  UnitServiced _mapUnitServiced(
    UnitServicedModel m, [
    int? parentVisitId,
  ]) => UnitServiced(
    unitServicedId: m.unitServicedId,
    visitId:
        m.visitId ??
        parentVisitId ??
        _requireInt(m.visitId, 'unitServiced.visitId'),
    unitName: m.unitName,
    issue: m.issue,
    action: m.action,
    status: m.status,
    notes: m.notes,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  VisitStats _mapStats(VisitStatsModel m) => VisitStats(
    dailyCount: m.dailyCount,
    weeklyCount: m.weeklyCount,
    productSoldWeekly: m.productSoldWeekly,
    unitServiceWeekly: m.unitServiceWeekly,
    rushHour: m.rushHour,
  );

  NetworkException _unexpected(String msg) =>
      NetworkException(type: NetworkErrorType.unknown, message: msg);

  // ---------- VISIT ----------
  @override
  /// Method `getAllVisits` returning `Future<ApiResponse<List<Visit>>>`.
  /// Handles logic operations related to `getAllVisits`.
  Future<ApiResponse<List<Visit>>> getAllVisits() async {
    final res = await _remote.getAllVisits();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.visits;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visits is null'),
      );
    }

    return ApiResponse.success(list.map(_mapVisit).toList());
  }

  @override
  /// Method `getVisitList` returning `Future<ApiResponse<List<Visit>>>`.
  /// Handles logic operations related to `getVisitList`.
  Future<ApiResponse<List<Visit>>> getVisitList() async {
    final res = await _remote.getVisitList();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.visits;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visitList is null'),
      );
    }

    return ApiResponse.success(list.map(_mapVisit).toList());
  }

  @override
  /// Method `getVisitStats` returning `Future<ApiResponse<VisitStats>>`.
  /// Handles logic operations related to `getVisitStats`.
  Future<ApiResponse<VisitStats>> getVisitStats() async {
    final res = await _remote.getVisitStats();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final statsModel = res.data?.stats;
    if (statsModel == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: stats is null'),
      );
    }

    return ApiResponse.success(_mapStats(statsModel));
  }

  @override
  /// Method `getVisitors` returning `Future<ApiResponse<List<Visitor>>>`.
  /// Handles logic operations related to `getVisitors`.
  Future<ApiResponse<List<Visitor>>> getVisitors() async {
    final res = await _remote.getVisitors();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.visitors;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visitors is null'),
      );
    }

    return ApiResponse.success(list.map(_mapVisitor).toList());
  }

  @override
  /// Method `getVisitorDetail` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `getVisitorDetail`.
  Future<ApiResponse<Visitor>> getVisitorDetail(int visitorId) async {
    final res = await _remote.getVisitorDetail(visitorId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final v = res.data?.visitor;
    if (v == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visitor detail is null'),
      );
    }

    return ApiResponse.success(_mapVisitor(v));
  }

  @override
  /// Method `createVisitor` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `createVisitor`.
  Future<ApiResponse<Visitor>> createVisitor(VisitorRequest request) async {
    final res = await _remote.createVisitor(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final v = res.data?.visitor;
    if (v == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visitor is null (createVisitor)'),
      );
    }

    return ApiResponse.success(_mapVisitor(v));
  }

  @override
  /// Method `updateVisitor` returning `Future<ApiResponse<Visitor>>`.
  /// Handles logic operations related to `updateVisitor`.
  Future<ApiResponse<Visitor>> updateVisitor(
    int visitorId,
    VisitorRequest request,
  ) async {
    final res = await _remote.updateVisitor(visitorId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final v = res.data?.visitor;
    if (v == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visitor is null (updateVisitor)'),
      );
    }

    return ApiResponse.success(_mapVisitor(v));
  }

  @override
  /// Method `deleteVisitor` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteVisitor`.
  Future<ApiResponse<int>> deleteVisitor(int visitorId) async {
    final res = await _remote.deleteVisitor(visitorId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final id = res.data?.deletedId;
    if (id == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: deletedId is null (deleteVisitor)',
        ),
      );
    }

    return ApiResponse.success(id);
  }

  @override
  /// Method `getVisitDetail` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `getVisitDetail`.
  Future<ApiResponse<Visit>> getVisitDetail(int visitId) async {
    final res = await _remote.getVisitDetail(visitId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final v = res.data?.visitDetail;
    if (v == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visitDetail is null'),
      );
    }

    return ApiResponse.success(_mapVisit(v));
  }

  @override
  /// Method `createVisit` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `createVisit`.
  Future<ApiResponse<Visit>> createVisit(VisitRequest request) async {
    final res = await _remote.createVisit(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final v = res.data?.visit;
    if (v == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visit is null (createVisit)'),
      );
    }

    return ApiResponse.success(_mapVisit(v));
  }

  @override
  /// Method `updateVisit` returning `Future<ApiResponse<Visit>>`.
  /// Handles logic operations related to `updateVisit`.
  Future<ApiResponse<Visit>> updateVisit(
    int visitId,
    VisitRequest request,
  ) async {
    final res = await _remote.updateVisit(visitId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final v = res.data?.visit;
    if (v == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: visit is null (updateVisit)'),
      );
    }

    return ApiResponse.success(_mapVisit(v));
  }

  @override
  /// Method `deleteVisit` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteVisit`.
  Future<ApiResponse<int>> deleteVisit(int visitId) async {
    final res = await _remote.deleteVisit(visitId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final id = res.data?.deletedId;
    if (id == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: deletedId is null (deleteVisit)'),
      );
    }

    return ApiResponse.success(id);
  }

  // ---------- FOLLOW-UP ----------
  @override
  /// Method `getAllFollowUps` returning `Future<ApiResponse<List<FollowUp>>>`.
  /// Handles logic operations related to `getAllFollowUps`.
  Future<ApiResponse<List<FollowUp>>> getAllFollowUps() async {
    final res = await _remote.getAllFollowUps();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.followUps;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: followUps is null (getAllFollowUps)',
        ),
      );
    }

    return ApiResponse.success(list.map(_mapFollowUp).toList());
  }

  @override
  /// Method `getFollowUps` returning `Future<ApiResponse<List<FollowUp>>>`.
  /// Handles logic operations related to `getFollowUps`.
  Future<ApiResponse<List<FollowUp>>> getFollowUps(int visitId) async {
    final res = await _remote.getFollowUps(visitId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.followUps;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: followUps is null'),
      );
    }

    return ApiResponse.success(
      list.map((m) => _mapFollowUp(m, visitId)).toList(),
    );
  }

  @override
  /// Method `addFollowUp` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `addFollowUp`.
  Future<ApiResponse<FollowUp>> addFollowUp(FollowUpRequest request) async {
    final res = await _remote.addFollowUp(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.followUp;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: followUp is null (addFollowUp)'),
      );
    }

    return ApiResponse.success(_mapFollowUp(item));
  }

  @override
  /// Method `createFollowUp` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `createFollowUp`.
  Future<ApiResponse<FollowUp>> createFollowUp(
    int visitId,
    FollowUpRequest request,
  ) async {
    final res = await _remote.createFollowUp(visitId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.followUp;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: followUp is null (createFollowUp)',
        ),
      );
    }

    return ApiResponse.success(_mapFollowUp(item, visitId));
  }

  @override
  /// Method `updateFollowUpNonNested` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `updateFollowUpNonNested`.
  Future<ApiResponse<FollowUp>> updateFollowUpNonNested(
    int followUpId,
    FollowUpRequest request,
  ) async {
    final res = await _remote.updateFollowUpNonNested(followUpId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.followUp;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: followUp is null (updateFollowUpNonNested)',
        ),
      );
    }

    return ApiResponse.success(_mapFollowUp(item));
  }

  @override
  /// Method `updateFollowUp` returning `Future<ApiResponse<FollowUp>>`.
  /// Handles logic operations related to `updateFollowUp`.
  Future<ApiResponse<FollowUp>> updateFollowUp(
    int visitId,
    int followUpId,
    FollowUpRequest request,
  ) async {
    final res = await _remote.updateFollowUp(visitId, followUpId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.followUp;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: followUp is null (updateFollowUp)',
        ),
      );
    }

    return ApiResponse.success(_mapFollowUp(item, visitId));
  }

  @override
  /// Method `deleteFollowUpNonNested` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteFollowUpNonNested`.
  Future<ApiResponse<int>> deleteFollowUpNonNested(int followUpId) async {
    final res = await _remote.deleteFollowUpNonNested(followUpId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    // API returns followUpId in response
    final id = res.data?.deletedId ?? followUpId;
    return ApiResponse.success(id);
  }

  @override
  /// Method `deleteFollowUp` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteFollowUp`.
  Future<ApiResponse<int>> deleteFollowUp(int visitId, int followUpId) async {
    final res = await _remote.deleteFollowUp(visitId, followUpId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    // Visit nested delete only returns message, no ID — return followUpId
    final id = res.data?.deletedId ?? followUpId;
    return ApiResponse.success(id);
  }

  // ---------- PRODUCTS SOLD ----------
  @override
  /// Method `getProductsSold` returning `Future<ApiResponse<List<ProductSold>>>`.
  /// Handles logic operations related to `getProductsSold`.
  Future<ApiResponse<List<ProductSold>>> getProductsSold(int visitId) async {
    final res = await _remote.getProductsSold(visitId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.productsSold;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: productsSold is null'),
      );
    }

    return ApiResponse.success(list.map(_mapProductSold).toList());
  }

  @override
  /// Method `createProductSold` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `createProductSold`.
  Future<ApiResponse<ProductSold>> createProductSold(
    int visitId,
    ProductSoldRequest request,
  ) async {
    final res = await _remote.createProductSold(visitId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.productSold;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: productSold is null (createProductSold)',
        ),
      );
    }

    return ApiResponse.success(_mapProductSold(item));
  }

  @override
  /// Method `updateProductSold` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `updateProductSold`.
  Future<ApiResponse<ProductSold>> updateProductSold(
    int visitId,
    int productSoldId,
    ProductSoldRequest request,
  ) async {
    final res = await _remote.updateProductSold(visitId, productSoldId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.productSold;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: productSold is null (updateProductSold)',
        ),
      );
    }

    return ApiResponse.success(_mapProductSold(item));
  }

  @override
  /// Method `deleteProductSold` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteProductSold`.
  Future<ApiResponse<int>> deleteProductSold(
    int visitId,
    int productSoldId,
  ) async {
    final res = await _remote.deleteProductSold(visitId, productSoldId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final id = res.data?.deletedId;
    if (id == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: deletedId is null (deleteProductSold)',
        ),
      );
    }

    return ApiResponse.success(id);
  }

  @override
  /// Method `getAllProductsSold` returning `Future<ApiResponse<List<ProductSold>>>`.
  /// Handles logic operations related to `getAllProductsSold`.
  Future<ApiResponse<List<ProductSold>>> getAllProductsSold() async {
    final res = await _remote.getAllProductsSold();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.productsSold;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: productsSold is null'),
      );
    }

    return ApiResponse.success(list.map(_mapProductSold).toList());
  }

  @override
  /// Method `addProductSold` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `addProductSold`.
  Future<ApiResponse<ProductSold>> addProductSold(
    ProductSoldRequest request,
  ) async {
    final res = await _remote.addProductSold(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.productSold;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: productSold is null (addProductSold)',
        ),
      );
    }

    return ApiResponse.success(_mapProductSold(item));
  }

  @override
  /// Method `updateProductSoldNonNested` returning `Future<ApiResponse<ProductSold>>`.
  /// Handles logic operations related to `updateProductSoldNonNested`.
  Future<ApiResponse<ProductSold>> updateProductSoldNonNested(
    int productSoldId,
    ProductSoldRequest request,
  ) async {
    final res = await _remote.updateProductSoldNonNested(productSoldId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.productSold;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: productSold is null (updateProductSoldNonNested)',
        ),
      );
    }

    return ApiResponse.success(_mapProductSold(item));
  }

  @override
  /// Method `deleteProductSoldNonNested` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteProductSoldNonNested`.
  Future<ApiResponse<int>> deleteProductSoldNonNested(
    int productSoldId,
  ) async {
    final res = await _remote.deleteProductSoldNonNested(productSoldId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final id = res.data?.deletedId;
    if (id == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: deletedId is null (deleteProductSoldNonNested)',
        ),
      );
    }

    return ApiResponse.success(id);
  }

  // ---------- UNITS SERVICED ----------
  @override
  /// Method `getUnitsServiced` returning `Future<ApiResponse<List<UnitServiced>>>`.
  /// Handles logic operations related to `getUnitsServiced`.
  Future<ApiResponse<List<UnitServiced>>> getUnitsServiced(int visitId) async {
    final res = await _remote.getUnitsServiced(visitId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.unitsServiced;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: unitsServiced is null'),
      );
    }

    return ApiResponse.success(list.map(_mapUnitServiced).toList());
  }

  @override
  /// Method `createUnitServiced` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `createUnitServiced`.
  Future<ApiResponse<UnitServiced>> createUnitServiced(
    int visitId,
    UnitServicedRequest request,
  ) async {
    final res = await _remote.createUnitServiced(visitId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.unitServiced;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: unitServiced is null (createUnitServiced)',
        ),
      );
    }

    return ApiResponse.success(_mapUnitServiced(item));
  }

  @override
  /// Method `updateUnitServiced` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `updateUnitServiced`.
  Future<ApiResponse<UnitServiced>> updateUnitServiced(
    int visitId,
    int unitServicedId,
    UnitServicedRequest request,
  ) async {
    final res = await _remote.updateUnitServiced(
      visitId,
      unitServicedId,
      request,
    );
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.unitServiced;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: unitServiced is null (updateUnitServiced)',
        ),
      );
    }

    return ApiResponse.success(_mapUnitServiced(item));
  }

  @override
  /// Method `deleteUnitServiced` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteUnitServiced`.
  Future<ApiResponse<int>> deleteUnitServiced(
    int visitId,
    int unitServicedId,
  ) async {
    final res = await _remote.deleteUnitServiced(visitId, unitServicedId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final id = res.data?.deletedId;
    if (id == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: deletedId is null (deleteUnitServiced)',
        ),
      );
    }

    return ApiResponse.success(id);
  }

  @override
  /// Method `getAllUnitsServiced` returning `Future<ApiResponse<List<UnitServiced>>>`.
  /// Handles logic operations related to `getAllUnitsServiced`.
  Future<ApiResponse<List<UnitServiced>>> getAllUnitsServiced() async {
    final res = await _remote.getAllUnitsServiced();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.unitsServiced;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: unitsServiced is null'),
      );
    }

    return ApiResponse.success(list.map(_mapUnitServiced).toList());
  }

  @override
  /// Method `addUnitServiced` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `addUnitServiced`.
  Future<ApiResponse<UnitServiced>> addUnitServiced(
    UnitServicedRequest request,
  ) async {
    final res = await _remote.addUnitServiced(request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.unitServiced;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: unitServiced is null (addUnitServiced)',
        ),
      );
    }

    return ApiResponse.success(_mapUnitServiced(item));
  }

  @override
  /// Method `updateUnitServicedNonNested` returning `Future<ApiResponse<UnitServiced>>`.
  /// Handles logic operations related to `updateUnitServicedNonNested`.
  Future<ApiResponse<UnitServiced>> updateUnitServicedNonNested(
    int unitServicedId,
    UnitServicedRequest request,
  ) async {
    final res = await _remote.updateUnitServicedNonNested(
      unitServicedId,
      request,
    );
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.unitServiced;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: unitServiced is null (updateUnitServicedNonNested)',
        ),
      );
    }

    return ApiResponse.success(_mapUnitServiced(item));
  }

  @override
  /// Method `deleteUnitServicedNonNested` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteUnitServicedNonNested`.
  Future<ApiResponse<int>> deleteUnitServicedNonNested(
    int unitServicedId,
  ) async {
    final res = await _remote.deleteUnitServicedNonNested(unitServicedId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final id = res.data?.deletedId;
    if (id == null) {
      return ApiResponse.failure(
        _unexpected(
          'Unexpected response: deletedId is null (deleteUnitServicedNonNested)',
        ),
      );
    }

    return ApiResponse.success(id);
  }
}
