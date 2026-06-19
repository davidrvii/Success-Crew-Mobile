/// File: lib/features/home/domain/entities/home_request_summary.dart
/// Generated Documentation for home_request_summary.dart

/// Class representing `HomeRequestSummary`.
/// Auto-generated class documentation.
class HomeRequestSummary {
  final int pendingLeaveCount;
  final int pendingOutOfOfficeCount;
  final int pendingOvertimeCount;

  const HomeRequestSummary({
    required this.pendingLeaveCount,
    required this.pendingOutOfOfficeCount,
    required this.pendingOvertimeCount,
  });

  /// Getter for `totalPending` returning `int`.
  int get totalPending =>
      pendingLeaveCount + pendingOutOfOfficeCount + pendingOvertimeCount;
}
