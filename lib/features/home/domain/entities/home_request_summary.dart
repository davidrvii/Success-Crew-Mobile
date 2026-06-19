class HomeRequestSummary {
  final int pendingLeaveCount;
  final int pendingOutOfOfficeCount;
  final int pendingOvertimeCount;

  const HomeRequestSummary({
    required this.pendingLeaveCount,
    required this.pendingOutOfOfficeCount,
    required this.pendingOvertimeCount,
  });

  int get totalPending =>
      pendingLeaveCount + pendingOutOfOfficeCount + pendingOvertimeCount;
}
