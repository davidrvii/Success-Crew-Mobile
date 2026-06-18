class VisitStats {
  final VisitDailyCount? dailyCount;
  final List<VisitWeeklyCount>? weeklyCount;
  final List<VisitRushHour>? rushHour;

  const VisitStats({
    this.dailyCount,
    this.weeklyCount,
    this.rushHour,
  });
}

class VisitDailyCount {
  final int totalVisit;
  final int callIn;
  final int chatIn;
  final int walkIn;
  final int totalUnitService;
  final int totalProductSold;

  const VisitDailyCount({
    required this.totalVisit,
    required this.callIn,
    required this.chatIn,
    required this.walkIn,
    required this.totalUnitService,
    required this.totalProductSold,
  });
}

class VisitWeeklyCount {
  final String date;
  final int totalVisit;

  const VisitWeeklyCount({
    required this.date,
    required this.totalVisit,
  });
}

class VisitRushHour {
  final String hour;
  final int totalVisit;

  const VisitRushHour({
    required this.hour,
    required this.totalVisit,
  });
}
