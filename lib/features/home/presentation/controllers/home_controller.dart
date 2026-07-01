/// File: lib/features/home/presentation/controllers/home_controller.dart
/// Generated Documentation for home_controller.dart

import 'package:flutter/foundation.dart';

import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';

import '../../domain/entities/home_summary.dart';
import '../../domain/entities/home_attendance_summary.dart';
import '../../domain/usecases/get_home_summary_request.dart';
import '../../domain/usecases/refresh_home_summary_request.dart';
import '../../../visitor_tracker/domain/entities/visit_stats.dart';
import '../../../visitor_tracker/domain/usecases/get_visit_stats.dart';

/// Class representing `HomeController`.
/// Auto-generated class documentation.
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
  /// Getter for `summary` returning `HomeSummary?`.
  HomeSummary? get summary => _summary;

  VisitStats? _visitStats;
  /// Getter for `visitStats` returning `VisitStats?`.
  VisitStats? get visitStats => _visitStats;

  NetworkException? _error;
  /// Getter for `error` returning `NetworkException?`.
  NetworkException? get error => _error;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _error?.message;

  bool _isLoading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _isLoading;

  bool _isRefreshing = false;
  /// Getter for `isRefreshing` returning `bool`.
  bool get isRefreshing => _isRefreshing;

  /// Getter for `hasData` returning `bool`.
  bool get hasData => _summary != null && _visitStats != null;
  /// Getter for `hasError` returning `bool`.
  bool get hasError => _error != null;

  /// Getter for `isInitialLoading` returning `bool`.
  bool get isInitialLoading => _isLoading && (_summary == null || _visitStats == null);

  String _selectedLocation = 'Semua';
  /// Getter for `selectedLocation` returning `String`.
  String get selectedLocation => _selectedLocation;

  int _requestToken = 0;

  /// Method `init` returning `Future<void>`.
  /// Handles logic operations related to `init`.
  Future<void> init() async {
    if ((_summary != null && _visitStats != null) || _isLoading) return;
    await load();
  }

  /// Method `load` returning `Future<void>`.
  /// Handles logic operations related to `load`.
  Future<void> load() async {
    final myToken = ++_requestToken;

    _setLoading(true);
    _setRefreshing(false);
    _setError(null);

    final results = await Future.wait([
      _getHomeSummaryUseCase(),
      _getVisitStatsUseCase(location: _selectedLocation == 'Semua' ? null : _selectedLocation.toLowerCase()),
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

  /// Method `refresh` returning `Future<void>`.
  /// Handles logic operations related to `refresh`.
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
      _getVisitStatsUseCase(location: _selectedLocation == 'Semua' ? null : _selectedLocation.toLowerCase()),
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

  /// Method `retry` returning `Future<void>`.
  /// Handles logic operations related to `retry`.
  Future<void> retry() => load();

  /// Method `changeLocation` returning `Future<void>`.
  /// Handles logic operations related to `changeLocation`.
  Future<void> changeLocation(String location) async {
    if (_selectedLocation == location) return;
    _selectedLocation = location;
    notifyListeners();

    final myToken = ++_requestToken;
    _setLoading(true);
    _setError(null);

    final res = await _getVisitStatsUseCase(
      location: location == 'Semua' ? null : location.toLowerCase(),
    );

    if (myToken != _requestToken) return;

    if (res.isSuccess) {
      _visitStats = res.data;
      _setError(null);
    } else {
      _setError(res.error);
    }
    _setLoading(false);
  }

  /// Method `clearError` returning `void`.
  /// Handles logic operations related to `clearError`.
  void clearError() => _setError(null);

  /// Method `reset` returning `void`.
  /// Handles logic operations related to `reset`.
  void reset() {
    _requestToken++;
    _summary = null;
    _visitStats = null;
    _error = null;
    _isLoading = false;
    _isRefreshing = false;
    notifyListeners();
  }

  /// Method `_setLoading` returning `void`.
  /// Handles logic operations related to `_setLoading`.
  void _setLoading(bool value) {
    if (_isLoading == value) return;
    _isLoading = value;
    notifyListeners();
  }

  /// Method `_setRefreshing` returning `void`.
  /// Handles logic operations related to `_setRefreshing`.
  void _setRefreshing(bool value) {
    if (_isRefreshing == value) return;
    _isRefreshing = value;
    notifyListeners();
  }

  /// Method `_setError` returning `void`.
  /// Handles logic operations related to `_setError`.
  void _setError(NetworkException? value) {
    if (_error == value) return;
    _error = value;
    notifyListeners();
  }

  // ======= Derived UI helpers =======

  /// Method `_toTitleCase` returning `String`.
  /// Handles logic operations related to `_toTitleCase`.
  String _toTitleCase(String? s) {
    if (s == null || s.trim().isEmpty) return '-';
    return s.trim().split(' ').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }

  /// Getter for `userName` returning `String`.
  String get userName => _summary?.user.userName ?? '-';
  /// Getter for `roleName` returning `String`.
  String get roleName => _toTitleCase(_summary?.user.roleName);
  /// Getter for `unreadNotif` returning `int`.
  int get unreadNotif => _summary?.unreadNotificationCount ?? 0;
  /// Getter for `todayAbsence` returning `HomeTodayAbsence?`.
  HomeTodayAbsence? get todayAbsence => _summary?.attendance.today;

  /// Getter for `visitorsToday` returning `int`.
  int get visitorsToday => _summary?.visitors.visitorsToday ?? 0;
  /// Getter for `walkInToday` returning `int`.
  int get walkInToday => _summary?.visitors.walkInToday ?? 0;
  /// Getter for `callInToday` returning `int`.
  int get callInToday => _summary?.visitors.callInToday ?? 0;
  /// Getter for `chatInToday` returning `int`.
  int get chatInToday => _summary?.visitors.chatInToday ?? 0;

  /// Getter for `present` returning `int`.
  int get present => _summary?.attendance.presentCount ?? 0;
  /// Getter for `late` returning `int`.
  int get late => _summary?.attendance.lateCount ?? 0;
  /// Getter for `leave` returning `int`.
  int get leave => _summary?.attendance.leaveCount ?? 0;
  /// Getter for `overtime` returning `int`.
  int get overtime => _summary?.attendance.overtimeCount ?? 0;
  /// Getter for `outOfOffice` returning `int`.
  int get outOfOffice => _summary?.attendance.outOfOfficeCount ?? 0;

  /// Getter for `pendingLeave` returning `int`.
  int get pendingLeave => _summary?.requests.pendingLeaveCount ?? 0;
  /// Getter for `pendingOutOfOffice` returning `int`.
  int get pendingOutOfOffice => _summary?.requests.pendingOutOfOfficeCount ?? 0;
  /// Getter for `pendingOvertime` returning `int`.
  int get pendingOvertime => _summary?.requests.pendingOvertimeCount ?? 0;

  /// Getter for `totalServicesThisWeek` returning `int`.
  int get totalServicesThisWeek => _summary?.visitors.totalServicesThisWeek ?? 0;
  /// Getter for `totalProductsSoldThisWeek` returning `int`.
  int get totalProductsSoldThisWeek => _summary?.visitors.totalProductsSoldThisWeek ?? 0;
}
