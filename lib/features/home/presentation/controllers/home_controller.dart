import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';

import '../../domain/entities/home_summary.dart';
import '../../domain/usecases/get_home_summary_request.dart';
import '../../domain/usecases/refresh_home_summary_request.dart';

class HomeController extends ChangeNotifier {
  final GetHomeSummaryUseCase _getHomeSummaryUseCase;
  final RefreshHomeSummaryUseCase _refreshHomeSummaryUseCase;

  HomeController({
    required GetHomeSummaryUseCase getHomeSummaryUseCase,
    required RefreshHomeSummaryUseCase refreshHomeSummaryUseCase,
  }) : _getHomeSummaryUseCase = getHomeSummaryUseCase,
       _refreshHomeSummaryUseCase = refreshHomeSummaryUseCase;

  HomeSummary? _summary;
  HomeSummary? get summary => _summary;

  NetworkException? _error;
  NetworkException? get error => _error;
  String? get errorMessage => _error?.message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  bool get hasData => _summary != null;
  bool get hasError => _error != null;

  bool get isInitialLoading => _isLoading && _summary == null;

  int _requestToken = 0;

  Future<void> init() async {
    if (_summary != null || _isLoading) return;
    await load();
  }

  Future<void> load() async {
    final myToken = ++_requestToken;

    _setLoading(true);
    _setRefreshing(false);
    _setError(null);

    final ApiResponse<HomeSummary> res = await _getHomeSummaryUseCase();

    if (myToken != _requestToken) return;

    if (res.isSuccess) {
      _summary = res.data;
      _setError(null);
    } else {
      _setError(res.error);
    }

    _setLoading(false);
  }

  Future<void> refresh() async {
    final myToken = ++_requestToken;

    if (_summary != null) {
      _setRefreshing(true);
    } else {
      _setLoading(true);
    }

    _setError(null);

    final ApiResponse<HomeSummary> res = await _refreshHomeSummaryUseCase();

    if (myToken != _requestToken) return;

    if (res.isSuccess) {
      _summary = res.data;
      _setError(null);
    } else {
      _setError(res.error);
    }

    _setRefreshing(false);
    _setLoading(false);
  }

  Future<void> retry() => load();

  void clearError() => _setError(null);

  void reset() {
    _requestToken++;
    _summary = null;
    _error = null;
    _isLoading = false;
    _isRefreshing = false;
    notifyListeners();
  }

  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  void _setRefreshing(bool value) {
    if (_isRefreshing == value) return;
    _isRefreshing = value;
    notifyListeners();
  }

  void _setError(NetworkException? value) {
    if (_error == value) return;
    _error = value;
    notifyListeners();
  }

  // ======= Derived UI helpers =======

  String _toTitleCase(String? s) {
    if (s == null || s.trim().isEmpty) return '-';
    return s.trim().split(' ').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }

  String get userName => _summary?.user.userName ?? '-';
  String get roleName => _toTitleCase(_summary?.user.roleName);
  int get unreadNotif => _summary?.unreadNotificationCount ?? 0;

  int get visitorsToday => _summary?.visitors.visitorsToday ?? 0;
  int get walkInToday => _summary?.visitors.walkInToday ?? 0;
  int get callInToday => _summary?.visitors.callInToday ?? 0;
  int get chatInToday => _summary?.visitors.chatInToday ?? 0;

  int get present => _summary?.attendance.presentCount ?? 0;
  int get late => _summary?.attendance.lateCount ?? 0;
  int get leave => _summary?.attendance.leaveCount ?? 0;
  int get overtime => _summary?.attendance.overtimeCount ?? 0;
  int get outOfOffice => _summary?.attendance.outOfOfficeCount ?? 0;

  int get pendingLeave => _summary?.requests.pendingLeaveCount ?? 0;
  int get pendingOutOfOffice => _summary?.requests.pendingOutOfOfficeCount ?? 0;
  int get pendingOvertime => _summary?.requests.pendingOvertimeCount ?? 0;

  int get totalServicesThisWeek => _summary?.visitors.totalServicesThisWeek ?? 0;
  int get totalProductsSoldThisWeek => _summary?.visitors.totalProductsSoldThisWeek ?? 0;
}
