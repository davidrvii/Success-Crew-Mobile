import 'package:flutter/material.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../../domain/usecases/get_crew_detail.dart';
import '../../domain/usecases/get_crew_attendance_history.dart';

class CrewDetailController extends ChangeNotifier {
  final GetCrewDetailUseCase _getCrewDetail;
  final GetCrewAttendanceHistoryUseCase _getCrewAttendanceHistory;

  CrewDetailController({
    required GetCrewDetailUseCase getCrewDetailUseCase,
    required GetCrewAttendanceHistoryUseCase getCrewAttendanceHistoryUseCase,
  })  : _getCrewDetail = getCrewDetailUseCase,
        _getCrewAttendanceHistory = getCrewAttendanceHistoryUseCase;

  // ===== Loading states =====
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // ===== Data states =====
  UserDetail? _detail;
  UserDetail? get detail => _detail;

  AttendanceHistoryData? _stats;
  AttendanceHistoryData? get stats => _stats;

  // ===== Pagination states =====
  List<Attendance> _allHistory = [];
  List<Attendance> _displayedHistory = [];
  List<Attendance> get displayedHistory => _displayedHistory;

  int _currentPage = 1;
  final int _pageSize = 5;

  bool _hasMore = false;
  bool get hasMore => _hasMore;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  // ===== Computed fields for UI (matching ProfileController layout) =====
  String get displayName => _detail?.userName ?? '-';
  String get displayRole => _detail?.roleName ?? '-';
  String get displayEmail => _detail?.userEmail ?? '-';
  String get displayEmployeeId => _detail?.userId.toString() ?? '-';
  String get displayPhone => '-';
  String get displayBirthDate => '-';
  String get displayStartWorkDate => '-';
  String get displayDivision => _detail?.roleName ?? '-';
  String get displayPosition => _detail?.roleName ?? '-';
  String get displayLocation => _detail?.officeName ?? '-';
  String get displayEmploymentStatus => 'Karyawan Tetap - Aktif';

  // Stats
  int get presentCount => _stats?.presentCount ?? 0;
  int get lateCount => _stats?.lateCount ?? 0;
  int get leaveCount => _stats?.leaveCount ?? 0;
  int get overtimeCount => _stats?.overtimeCount ?? 0;

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

  Future<void> refresh(int userId) => init(userId);

  String _extractError(dynamic err) {
    try {
      final m = (err?.message as String?);
      if (m != null && m.trim().isNotEmpty) return m.trim();
    } catch (_) {}
    return 'Terjadi kesalahan. Silakan coba lagi.';
  }
}
