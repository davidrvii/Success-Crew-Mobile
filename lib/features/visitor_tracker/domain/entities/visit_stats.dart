/// File: lib/features/visitor_tracker/domain/entities/visit_stats.dart
/// Generated Documentation for visit_stats.dart

/// Class representing `VisitStats`.
/// Auto-generated class documentation.
class VisitStats {
  final VisitDailyCount? dailyCount;
  final List<VisitWeeklyCount>? weeklyCount;
  final List<ProductSoldWeekly>? productSoldWeekly;
  final List<UnitServiceWeekly>? unitServiceWeekly;
  final List<VisitRushHour>? rushHour;

  const VisitStats({
    this.dailyCount,
    this.weeklyCount,
    this.productSoldWeekly,
    this.unitServiceWeekly,
    this.rushHour,
  });
}

/// Class representing `ProductSoldWeekly`.
/// Auto-generated class documentation.
class ProductSoldWeekly {
  final String date;
  final int totalProductSold;

  const ProductSoldWeekly({
    required this.date,
    required this.totalProductSold,
  });
}

/// Class representing `UnitServiceWeekly`.
/// Auto-generated class documentation.
class UnitServiceWeekly {
  final String date;
  final int totalUnitService;

  const UnitServiceWeekly({
    required this.date,
    required this.totalUnitService,
  });
}

/// Class representing `VisitDailyCount`.
/// Auto-generated class documentation.
class VisitDailyCount {
  final int totalVisit;
  final int callIn;
  final int chatIn;
  final int walkIn;
  final int unitServiced;
  final int productSold;

  const VisitDailyCount({
    required this.totalVisit,
    required this.callIn,
    required this.chatIn,
    required this.walkIn,
    required this.unitServiced,
    required this.productSold,
  });
}

/// Class representing `VisitWeeklyCount`.
/// Auto-generated class documentation.
class VisitWeeklyCount {
  final String date;
  final int totalVisit;

  const VisitWeeklyCount({
    required this.date,
    required this.totalVisit,
  });
}

/// Class representing `VisitRushHour`.
/// Auto-generated class documentation.
class VisitRushHour {
  final String hour;
  final int totalVisit;

  const VisitRushHour({
    required this.hour,
    required this.totalVisit,
  });
}
