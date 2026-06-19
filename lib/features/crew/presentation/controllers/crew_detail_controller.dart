/// File: lib/features/crew/presentation/controllers/crew_detail_controller.dart
/// Generated Documentation for crew_detail_controller.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../../domain/usecases/get_crew_detail.dart';
import '../../domain/usecases/get_crew_attendance_history.dart';
import '../../domain/usecases/update_crew.dart';
import '../../data/models/crew_request.dart';

/// Class representing `CrewDetailController`.
/// Auto-generated class documentation.
class CrewDetailController extends ChangeNotifier {
  final GetCrewDetailUseCase _getCrewDetail;
  final GetCrewAttendanceHistoryUseCase _getCrewAttendanceHistory;
  final UpdateCrewUseCase _updateCrew;

  CrewDetailController({
    required GetCrewDetailUseCase getCrewDetailUseCase,
    required GetCrewAttendanceHistoryUseCase getCrewAttendanceHistoryUseCase,
    required UpdateCrewUseCase updateCrewUseCase,
  })  : _getCrewDetail = getCrewDetailUseCase,
        _getCrewAttendanceHistory = getCrewAttendanceHistoryUseCase,
        _updateCrew = updateCrewUseCase;

  // ===== Loading states =====
  bool _isLoading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _isLoading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  // ===== Data states =====
  UserDetail? _detail;
  /// Getter for `detail` returning `UserDetail?`.
  UserDetail? get detail => _detail;

  AttendanceHistoryData? _stats;
  /// Getter for `stats` returning `AttendanceHistoryData?`.
  AttendanceHistoryData? get stats => _stats;

  // ===== Pagination states =====
  List<Attendance> _allHistory = [];
  List<Attendance> _displayedHistory = [];
  /// Getter for `displayedHistory` returning `List<Attendance>`.
  List<Attendance> get displayedHistory => _displayedHistory;

  int _currentPage = 1;
  final int _pageSize = 5;

  bool _hasMore = false;
  /// Getter for `hasMore` returning `bool`.
  bool get hasMore => _hasMore;

  bool _isLoadingMore = false;
  /// Getter for `isLoadingMore` returning `bool`.
  bool get isLoadingMore => _isLoadingMore;

  // ===== Computed fields for UI (matching ProfileController layout) =====
  /// Method `_toTitleCase` returning `String`.
  /// Handles logic operations related to `_toTitleCase`.
  String _toTitleCase(String? s) {
    if (s == null || s.trim().isEmpty) return '-';
    return s.trim().split(' ').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1)}').join(' ');
  }

  /// Getter for `displayName` returning `String`.
  String get displayName => _detail?.userName ?? '-';
  /// Getter for `displayRole` returning `String`.
  String get displayRole => _toTitleCase(_detail?.roleName);
  /// Getter for `displayEmail` returning `String`.
  String get displayEmail => _detail?.userEmail ?? '-';
  /// Getter for `displayEmployeeId` returning `String`.
  String get displayEmployeeId => _detail?.userId.toString() ?? '-';
  /// Getter for `displayPhone` returning `String`.
  String get displayPhone => _detail?.userPhone ?? '-';
  /// Getter for `displayBirthDate` returning `String`.
  String get displayBirthDate => _detail?.userBirth != null
      ? DateFormat('dd MMM yyyy').format(_detail!.userBirth!)
      : '-';
  /// Getter for `displayStartWorkDate` returning `String`.
  String get displayStartWorkDate => _detail?.startWork != null
      ? DateFormat('dd MMM yyyy').format(_detail!.startWork!)
      : '-';
  /// Getter for `displayEndWorkDate` returning `String`.
  String get displayEndWorkDate => _detail?.endWork != null
      ? DateFormat('dd MMM yyyy').format(_detail!.endWork!)
      : '-';
  /// Getter for `displayPosition` returning `String`.
  String get displayPosition => _toTitleCase(_detail?.roleName);
  /// Getter for `displayLocation` returning `String`.
  String get displayLocation => _detail?.officeName ?? '-';
  /// Getter for `displayEmploymentStatus` returning `String`.
  String get displayEmploymentStatus => _detail?.contractStatus != null
      ? '${_detail!.contractStatus} - ${_detail!.crewStatus ?? "-"}'
      : '-';

  // Stats
  /// Getter for `presentCount` returning `int`.
  int get presentCount => _stats?.presentCount ?? 0;
  /// Getter for `lateCount` returning `int`.
  int get lateCount => _stats?.lateCount ?? 0;
  /// Getter for `leaveCount` returning `int`.
  int get leaveCount => _stats?.leaveCount ?? 0;
  /// Getter for `overtimeCount` returning `int`.
  int get overtimeCount => _stats?.overtimeCount ?? 0;
  /// Getter for `outOfOfficeCount` returning `int`.
  int get outOfOfficeCount => _stats?.outOfOfficeCount ?? 0;

  /// Method `init` returning `Future<void>`.
  /// Handles logic operations related to `init`.
  Future<void> init(int userId) async {
    _isLoading = true;
    _errorMessage = null;
    _detail = null;
    _stats = null;
    _allHistory = [];
    _displayedHistory = [];
    _currentPage = 1;
    _hasMore = false;
    _isLoadingMore = false;
    notifyListeners();

    try {
      final detailRes = await _getCrewDetail(userId);
      if (!detailRes.isSuccess) {
        _errorMessage = _extractError(detailRes.error);
        _isLoading = false;
        notifyListeners();
        return;
      }
      _detail = detailRes.data;

      final historyRes = await _getCrewAttendanceHistory(userId);
      if (!historyRes.isSuccess) {
        _errorMessage = _extractError(historyRes.error);
        _isLoading = false;
        notifyListeners();
        return;
      }
      _stats = historyRes.data;
      _allHistory = _stats?.history ?? [];

      // Initial page load
      _displayedHistory = _allHistory.take(_pageSize).toList();
      _hasMore = _allHistory.length > _pageSize;
    } catch (e) {
      _errorMessage = 'Gagal memuat detail crew.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Method `loadMore` returning `Future<void>`.
  /// Handles logic operations related to `loadMore`.
  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    notifyListeners();

    // Small delay for smooth and premium loading experience
    await Future.delayed(const Duration(milliseconds: 500));

    final int nextOffset = _currentPage * _pageSize;
    final nextItems = _allHistory.skip(nextOffset).take(_pageSize).toList();

    _displayedHistory.addAll(nextItems);
    _currentPage++;
    _hasMore = _displayedHistory.length < _allHistory.length;

    _isLoadingMore = false;
    notifyListeners();
  }

  /// Method `refresh` returning `Future<void>`.
  /// Handles logic operations related to `refresh`.
  Future<void> refresh(int userId) => init(userId);

  /// Method `updateCrew` returning `Future<bool>`.
  /// Handles logic operations related to `updateCrew`.
  Future<bool> updateCrew(int userId, CrewRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final res = await _updateCrew(userId, request);
    _isLoading = false;

    if (res.isSuccess && res.data != null) {
      _detail = res.data;
      _fillUiFieldsFromDetail();
      notifyListeners();
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal mengubah crew.';
      notifyListeners();
      return false;
    }
  }

  /// Method `_fillUiFieldsFromDetail` returning `void`.
  /// Handles logic operations related to `_fillUiFieldsFromDetail`.
  void _fillUiFieldsFromDetail() {
    // If needed, we can sync or refresh the UI fields
  }

  /// Method `_extractError` returning `String`.
  /// Handles logic operations related to `_extractError`.
  String _extractError(dynamic err) {
    try {
      final m = (err?.message as String?);
      if (m != null && m.trim().isNotEmpty) return m.trim();
    } catch (_) {}
    return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}
