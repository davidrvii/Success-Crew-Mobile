class HomeVisitSummary {
  final int visitorsToday;
  final int walkInToday;
  final int callInToday;
  final int chatInToday;
  final num totalRevenue;
  final num totalDistance;
  final int totalServicesThisWeek;
  final int totalProductsSoldThisWeek;

  const HomeVisitSummary({
    required this.visitorsToday,
    required this.walkInToday,
    required this.callInToday,
    required this.chatInToday,
    required this.totalRevenue,
    required this.totalDistance,
    required this.totalServicesThisWeek,
    required this.totalProductsSoldThisWeek,
  });
}
