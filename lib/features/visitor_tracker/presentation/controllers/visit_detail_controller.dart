import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../domain/entities/visit.dart';
import '../../domain/entities/followup.dart';
import '../../domain/entities/product_sold.dart';
import '../../domain/entities/unit_serviced.dart';

import '../../domain/usecases/get_visit_detail.dart';
import '../../domain/usecases/get_followup.dart';
import '../../domain/usecases/get_product_sold.dart';
import '../../domain/usecases/get_unit_serviced.dart';

import '../../data/models/followup_request.dart';
import '../../data/models/product_sold_request.dart';
import '../../data/models/unit_serviced_request.dart';

import '../../domain/usecases/create_followup.dart';
import '../../domain/usecases/create_product_sold.dart';
import '../../domain/usecases/create_unit_serviced.dart';

import '../../domain/usecases/delete_followup.dart';
import '../../domain/usecases/delete_product_sold.dart';
import '../../domain/usecases/delete_unit_serviced.dart';
import '../../domain/usecases/delete_visit.dart';

class VisitDetailController extends ChangeNotifier {
  final GetVisitDetailUseCase _getVisitDetail;
  final GetFollowUpsUseCase _getFollowUp;
  final GetProductsSoldUseCase _getProductSold;
  final GetUnitsServicedUseCase _getUnitServiced;

  final CreateFollowUpUseCase _createFollowUp;
  final CreateProductSoldUseCase _createProductSold;
  final CreateUnitServicedUseCase _createUnitServiced;

  final DeleteFollowUpUseCase _deleteFollowUp;
  final DeleteProductSoldUseCase _deleteProductSold;
  final DeleteUnitServicedUseCase _deleteUnitServiced;
  final DeleteVisitUseCase _deleteVisit;

  VisitDetailController(
    this._getVisitDetail,
    this._getFollowUp,
    this._getProductSold,
    this._getUnitServiced,
    this._createFollowUp,
    this._createProductSold,
    this._createUnitServiced,
    this._deleteFollowUp,
    this._deleteProductSold,
    this._deleteUnitServiced,
    this._deleteVisit,
  );

  int? visitId;

  bool isLoading = false;
  String? errorMessage;
  Visit? visit;

  bool isLoadingFollowUps = false;
  String? followUpsError;
  List<FollowUp> followUps = const [];

  bool isLoadingProducts = false;
  String? productsError;
  List<ProductSold> products = const [];

  bool isLoadingUnits = false;
  String? unitsError;
  List<UnitServiced> units = const [];

  Future<void> init(int id) async {
    visitId = id;
    await refreshAll();
  }

  Future<void> refreshAll() async {
    if (visitId == null) return;
    await Future.wait([
      loadDetail(),
      loadFollowUps(),
      loadProducts(),
      loadUnits(),
    ]);
  }

  Future<void> loadDetail() async {
    if (visitId == null) return;

    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final ApiResponse<Visit> res = await _getVisitDetail(visitId!);

    if (!res.isSuccess) {
      isLoading = false;
      errorMessage = res.error?.message ?? 'Gagal memuat detail';
      notifyListeners();
      return;
    }

    visit = res.data;
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadFollowUps() async {
    if (visitId == null) return;

    isLoadingFollowUps = true;
    followUpsError = null;
    notifyListeners();

    final ApiResponse<List<FollowUp>> res = await _getFollowUp(visitId!);

    if (!res.isSuccess) {
      isLoadingFollowUps = false;
      followUpsError = res.error?.message ?? 'Gagal memuat follow up';
      notifyListeners();
      return;
    }

    followUps = res.data ?? const [];
    isLoadingFollowUps = false;
    notifyListeners();
  }

  Future<void> loadProducts() async {
    if (visitId == null) return;

    isLoadingProducts = true;
    productsError = null;
    notifyListeners();

    final ApiResponse<List<ProductSold>> res = await _getProductSold(visitId!);

    if (!res.isSuccess) {
      isLoadingProducts = false;
      productsError = res.error?.message ?? 'Gagal memuat produk terjual';
      notifyListeners();
      return;
    }

    products = res.data ?? const [];
    isLoadingProducts = false;
    notifyListeners();
  }

  Future<void> loadUnits() async {
    if (visitId == null) return;

    isLoadingUnits = true;
    unitsError = null;
    notifyListeners();

    final ApiResponse<List<UnitServiced>> res = await _getUnitServiced(
      visitId!,
    );

    if (!res.isSuccess) {
      isLoadingUnits = false;
      unitsError = res.error?.message ?? 'Gagal memuat unit servis';
      notifyListeners();
      return;
    }

    units = res.data ?? const [];
    isLoadingUnits = false;
    notifyListeners();
  }

  // ---------------------------
  // Create actions
  // ---------------------------

  Future<bool> submitFollowUp(String notes, String status) async {
    if (visitId == null) return false;
    isLoadingFollowUps = true;
    notifyListeners();

    final req = FollowUpRequest(notes: notes, status: status);
    final res = await _createFollowUp(visitId!, req);

    if (!res.isSuccess) {
      isLoadingFollowUps = false;
      followUpsError = res.error?.message;
      notifyListeners();
      return false;
    }
    
    await refreshAll();
    return true;
  }

  Future<bool> submitProductSold(String name, int qty, double price, String notes) async {
    if (visitId == null) return false;
    isLoadingProducts = true;
    notifyListeners();

    final req = ProductSoldRequest(
      productName: name,
      quantity: qty,
      price: price,
      notes: notes,
    );
    final res = await _createProductSold(visitId!, req);

    if (!res.isSuccess) {
      isLoadingProducts = false;
      productsError = res.error?.message;
      notifyListeners();
      return false;
    }
    
    await loadProducts();
    return true;
  }

  Future<bool> submitUnitServiced(String name, String issue, String action, String notes, String status) async {
    if (visitId == null) return false;
    isLoadingUnits = true;
    notifyListeners();

    final req = UnitServicedRequest(
      unitName: name,
      issue: issue,
      action: action,
      notes: notes,
      status: status,
    );
    final res = await _createUnitServiced(visitId!, req);

    if (!res.isSuccess) {
      isLoadingUnits = false;
      unitsError = res.error?.message;
      notifyListeners();
      return false;
    }
    
    await loadUnits();
    return true;
  }

  // ---------------------------
  // Delete actions
  // ---------------------------

  Future<bool> deleteVisit() async {
    if (visitId == null) return false;

    final ApiResponse<int> res = await _deleteVisit(visitId!);
    if (!res.isSuccess) return false;
    return true;
  }

  Future<bool> deleteFollowUpItem(int followUpId) async {
    if (visitId == null) return false;

    final res = await _deleteFollowUp(visitId!, followUpId);
    if (!res.isSuccess) return false;

    await refreshAll();
    return true;
  }

  Future<bool> deleteProductItem(int productSoldId) async {
    if (visitId == null) return false;

    final res = await _deleteProductSold(visitId!, productSoldId);
    if (!res.isSuccess) return false;

    await loadProducts();
    return true;
  }

  Future<bool> deleteUnitItem(int unitServicedId) async {
    if (visitId == null) return false;

    final res = await _deleteUnitServiced(visitId!, unitServicedId);
    if (!res.isSuccess) return false;

    await loadUnits();
    return true;
  }
}
