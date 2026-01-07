import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';

import '../../domain/entities/visit.dart';
import '../../domain/entities/followup.dart';
import '../../domain/entities/product_sold.dart';
import '../../domain/entities/unit_serviced.dart';
import '../../domain/repositories/visit_repository.dart';

import '../datasources/visit_remote_datasource.dart';

import '../models/visit_model.dart';
import '../models/followup_model.dart';
import '../models/product_sold_model.dart';
import '../models/unit_serviced_model.dart';

import '../models/visit_request.dart';
import '../models/followup_request.dart';
import '../models/product_sold_request.dart';
import '../models/unit_serviced_request.dart';

class VisitRepositoryImpl implements VisitRepository {
  final VisitRemoteDataSource _remote;
  const VisitRepositoryImpl(this._remote);

  // ---------- MAPPERS ----------
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
    userId: m.userId,
    customerName: m.customerName,
    customerPhone: m.customerPhone,
    customerAddress: m.customerAddress,
    purpose: m.purpose,
    status: m.status,
    notes: m.notes,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  FollowUp _mapFollowUp(FollowUpModel m) => FollowUp(
    followUpId: m.followUpId,
    visitId: m.followUpId,
    stage: m.stage,
    notes: m.notes,
    status: m.status,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  ProductSold _mapProductSold(ProductSoldModel m) => ProductSold(
    productSoldId: m.productSoldId,
    visitId: m.visitId!,
    productName: m.productName,
    quantity: m.quantity,
    price: m.price,
    total: m.total,
    notes: m.notes,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  UnitServiced _mapUnitServiced(UnitServicedModel m) => UnitServiced(
    unitServicedId: m.unitServicedId,
    visitId: _requireInt(m.visitId, 'unitServiced.visitId'),
    unitName: m.unitName,
    issue: m.issue,
    action: m.action,
    status: m.status,
    notes: m.notes,
    createdAt: m.createdAt,
    updatedAt: m.updatedAt,
  );

  NetworkException _unexpected(String msg) =>
      NetworkException(type: NetworkErrorType.unknown, message: msg);

  // ---------- VISIT ----------
  @override
  Future<ApiResponse<List<Visit>>> getAdminVisits() async {
    final res = await _remote.getAdminVisits();
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
  Future<ApiResponse<Visit>> getVisitDetail(String visitId) async {
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
  Future<ApiResponse<Visit>> updateVisit(
    String visitId,
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
  Future<ApiResponse<int>> deleteVisit(String visitId) async {
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
  Future<ApiResponse<List<FollowUp>>> getFollowUps(String visitId) async {
    final res = await _remote.getFollowUps(visitId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final list = res.data?.followUps;
    if (list == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: followUps is null'),
      );
    }

    return ApiResponse.success(list.map(_mapFollowUp).toList());
  }

  @override
  Future<ApiResponse<FollowUp>> createFollowUp(
    String visitId,
    FollowUpRequest request,
  ) async {
    final res = await _remote.createFollowUp(visitId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.followUp;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: followUp is null (createFollowUp)'),
      );
    }

    return ApiResponse.success(_mapFollowUp(item));
  }

  @override
  Future<ApiResponse<FollowUp>> updateFollowUp(
    String visitId,
    String followUpId,
    FollowUpRequest request,
  ) async {
    final res = await _remote.updateFollowUp(visitId, followUpId, request);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final item = res.data?.followUp;
    if (item == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: followUp is null (updateFollowUp)'),
      );
    }

    return ApiResponse.success(_mapFollowUp(item));
  }

  @override
  Future<ApiResponse<int>> deleteFollowUp(
    String visitId,
    String followUpId,
  ) async {
    final res = await _remote.deleteFollowUp(visitId, followUpId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final id = res.data?.deletedId;
    if (id == null) {
      return ApiResponse.failure(
        _unexpected('Unexpected response: deletedId is null (deleteFollowUp)'),
      );
    }

    return ApiResponse.success(id);
  }

  // ---------- PRODUCTS SOLD ----------
  @override
  Future<ApiResponse<List<ProductSold>>> getProductsSold(String visitId) async {
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
  Future<ApiResponse<ProductSold>> createProductSold(
    String visitId,
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
  Future<ApiResponse<ProductSold>> updateProductSold(
    String visitId,
    String productSoldId,
    ProductSoldRequest request,
  ) async {
    final res = await _remote.updateProductSold(
      visitId,
      productSoldId,
      request,
    );
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
  Future<ApiResponse<int>> deleteProductSold(
    String visitId,
    String productSoldId,
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

  // ---------- UNITS SERVICED ----------
  @override
  Future<ApiResponse<List<UnitServiced>>> getUnitsServiced(
    String visitId,
  ) async {
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
  Future<ApiResponse<UnitServiced>> createUnitServiced(
    String visitId,
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
  Future<ApiResponse<UnitServiced>> updateUnitServiced(
    String visitId,
    String unitServicedId,
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
  Future<ApiResponse<int>> deleteUnitServiced(
    String visitId,
    String unitServicedId,
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
}
