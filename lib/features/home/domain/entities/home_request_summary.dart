class HomeRequestSummary {
  final int pendingLeaveCount;
  final int pendingOvertimeCount;

  const HomeRequestSummary({
    required this.pendingLeaveCount,
    required this.pendingOvertimeCount,
  });

  int get totalPending => pendingLeaveCount + pendingOvertimeCount;
}
