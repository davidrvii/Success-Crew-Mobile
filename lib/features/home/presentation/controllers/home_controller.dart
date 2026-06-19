import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';

import '../../domain/entities/home_summary.dart';
import '../../domain/entities/home_attendance_summary.dart';
import '../../domain/usecases/get_home_summary_request.dart';
import '../../domain/usecases/refresh_home_summary_request.dart';
import '../../../visitor_tracker/domain/entities/visit_stats.dart';
import '../../../visitor_tracker/domain/usecases/get_visit_stats.dart';

class HomeController extends ChangeNotifier {
  final GetHomeSummaryUseCase _getHomeSummaryUseCase;
  final RefreshHomeSummaryUseCase _refreshHomeSummaryUseCase;
  final GetVisitStatsUseCase _getVisitStatsUseCase;

  HomeController({
    required GetHomeSummaryUseCase getHomeSummaryUseCase,
    required RefreshHomeSummaryUseCase refreshHomeSummaryUseCase,
    required GetVisitStatsUseCase getVisitStatsUseCase,
  }) : _getHomeSummaryUseCase = getHomeSummaryUseCase,
       _refreshHomeSummaryUseCase = refreshHomeSummaryUseCase,
       _getVisitStatsUseCase = getVisitStatsUseCase;

  HomeSummary? _summary;
  HomeSummary? get summary => _summary;

  VisitStats? _visitStats;
  VisitStats? get visitStats => _visitStats;

  NetworkException? _error;
  NetworkException? get error => _error;
  String? get errorMessage => _error?.message;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  bool get hasData => _summary != null && _visitStats != null;
  bool get hasError => _error != null;

  bool get isInitialLoading => _isLoading && (_summary == null || _visitStats == null);

  int _requestToken = 0;

  Future<void> init() async {
    if ((_summary != null && _visitStats != null) || _isLoading) return;
    await load();
  }

  Future<void> load() async {
    final myToken = ++_requestToken;

    _setLoading(true);
    _setRefreshing(false);
    _setError(null);

    final results = await Future.wait([
      _getHomeSummaryUseCase(),
      _getVisitStatsUseCase(),
    ]);

    if (myToken != _requestToken) return;

    final resSummary = results[0] as ApiResponse<HomeSummary>;
    final resStats = results[1] as ApiResponse<VisitStats>;

    if (resSummary.isSuccess && resStats.isSuccess) {
      _summary = resSummary.data;
      _visitStats = resStats.data;
      _setError(null);
    } else if (!resSummary.isSuccess) {
      _setError(resSummary.error);
    } else {
      _setError(resStats.error);
    }

    _setLoading(false);
  }

  Future<void> refresh() async {
    final myToken = ++_requestToken;

    if (_summary != null && _visitStats != null) {
      _setRefreshing(true);
    } else {
      _setLoading(true);
    }

    _setError(null);

    final results = await Future.wait([
      _refreshHomeSummaryUseCase(),
      _getVisitStatsUseCase(),
    ]);

    if (myToken != _requestToken) return;

    final resSummary = results[0] as ApiResponse<HomeSummary>;
    final resStats = results[1] as ApiResponse<VisitStats>;

    if (resSummary.isSuccess && resStats.isSuccess) {
      _summary = resSummary.data;
      _visitStats = resStats.data;
      _setError(null);
    } else if (!resSummary.isSuccess) {
      _setError(resSummary.error);
    } else {
      _setError(resStats.error);
    }

    _setRefreshing(false);
    _setLoading(false);
  }

  Future<void> retry() => load();

  void clearError() => _setError(null);

  void reset() {
    _requestToken++;
    _summary = null;
    _visitStats = null;
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
  HomeTodayAbsence? get todayAbsence => _summary?.attendance.today;

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
