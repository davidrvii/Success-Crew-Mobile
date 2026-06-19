import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../domain/entities/visit.dart';
import '../../domain/usecases/get_visits.dart';
import '../../domain/usecases/create_visit.dart';
import '../../domain/usecases/get_visitors.dart';
import '../../domain/entities/visitor.dart';
import '../../data/models/visit_request.dart';
import '../../../../core/network/api_response.dart';
import '../../domain/usecases/delete_visit.dart';

enum VisitorSortMode { newest, az }

class VisitorController extends ChangeNotifier {
  final GetVisitsUseCase _getVisits;
  final CreateVisitUseCase _createVisit;
  final GetVisitorsUseCase _getVisitors;
  final DeleteVisitUseCase _deleteVisit;

  VisitorController(this._getVisits, this._createVisit, this._getVisitors, this._deleteVisit);

  bool isLoading = false;
  String? errorMessage;

  final List<Visit> _all = [];
  List<Visit> visible = [];
  final List<Visitor> visitors = [];

  String query = '';
  VisitorSortMode sortMode = VisitorSortMode.newest;

  String? statusFilter;

  Timer? _debounce;

  int get totalCount => _all.length;

  Future<void> init() async {
    await refresh();
  }

  Future<void> refresh() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final ApiResponse<List<Visit>> res = await _getVisits();
    final ApiResponse<List<Visitor>> visitorRes = await _getVisitors();

    if (!res.isSuccess) {
      isLoading = false;
      errorMessage = res.error?.message ?? 'Gagal memuat data';
      notifyListeners();
      return;
    }

    _all
      ..clear()
      ..addAll(res.data ?? const []);

    if (visitorRes.isSuccess) {
      visitors
        ..clear()
        ..addAll(visitorRes.data ?? const []);
    }

    _apply();
    isLoading = false;
    notifyListeners();
  }

  Future<bool> submitVisit({
    required String visitorName,
    required String visitorPhone,
    required String visitorCompany,
    required String purpose,
    required String visitorCategory,
    required String visitDesc,
    required String visitType,
    required String status,
    required DateTime createdAt,
    required int? userId,
    int? visitorId,
    String? visitSales,
  }) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final req = VisitRequest(
      userId: userId,
      visitorId: visitorId,
      visitorName: visitorName,
      visitorPhone: visitorPhone,
      visitorCompany: visitorCompany,
      purpose: purpose,
      status: status,
      visitorCategory: visitorCategory,
      visitType: visitType,
      visitDesc: visitDesc,
      createdAt: createdAt,
      visitSales: visitSales,
    );

    final res = await _createVisit(req);

    if (res.isSuccess) {
      await refresh();
      return true;
    } else {
      isLoading = false;
      errorMessage = res.error?.message ?? 'Gagal membuat visit';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteVisit(int visitId) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    final ApiResponse<int> res = await _deleteVisit(visitId);

    if (res.isSuccess) {
      await refresh();
      return true;
    } else {
      isLoading = false;
      errorMessage = res.error?.message ?? 'Gagal menghapus kunjungan';
      notifyListeners();
      return false;
    }
  }

  void setQuery(String value) {
    query = value;
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), () {
      _apply();
      notifyListeners();
    });
  }

  void toggleSort() {
    sortMode = sortMode == VisitorSortMode.newest
        ? VisitorSortMode.az
        : VisitorSortMode.newest;
    _apply();
    notifyListeners();
  }

  void setStatusFilter(String? value) {
    statusFilter = value;
    _apply();
    notifyListeners();
  }

  void clearFilter() {
    statusFilter = null;
    _apply();
    notifyListeners();
  }

  void _apply() {
    Iterable<Visit> data = _all;

    if (statusFilter != null && statusFilter!.trim().isNotEmpty) {
      final f = statusFilter!.trim().toLowerCase();
      data = data.where((v) {
        final raw = (v.visitorStatus ?? '').trim().toLowerCase();
        final normalized = (raw == 'pending' || raw == 'proses')
            ? 'proses'
            : (raw == 'done' || raw == 'selesai')
                ? 'selesai'
                : (raw == 'cancel' || raw == 'batal')
                    ? 'batal'
                    : raw;
        return normalized == f;
      });
    }

    final q = query.trim().toLowerCase();
    if (q.isNotEmpty) {
      data = data.where((v) {
        final interest = (v.visitorInterest ?? '').toLowerCase();
        final type = (v.visitType ?? '').toLowerCase();
        final desc = (v.visitDesc ?? '').toLowerCase();
        return interest.contains(q) || type.contains(q) || desc.contains(q);
      });
    }

    final list = data.toList();

    if (sortMode == VisitorSortMode.az) {
      list.sort(
        (a, b) => (a.visitorInterest ?? '').compareTo(b.visitorInterest ?? ''),
      );
    } else {
      list.sort((a, b) {
        final ad = a.createdAt;
        final bd = b.createdAt;
        if (ad != null && bd != null) return bd.compareTo(ad);
        return (b.visitId).compareTo(a.visitId);
      });
    }

    visible = list;
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
