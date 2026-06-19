import '../../domain/entities/visit_stats.dart';

int _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v') ?? 0;

class VisitStatsModel extends VisitStats {
  const VisitStatsModel({
    super.dailyCount,
    super.weeklyCount,
    super.productSoldWeekly,
    super.unitServiceWeekly,
    super.rushHour,
  });

  factory VisitStatsModel.fromJson(Map<String, dynamic> json) {
    return VisitStatsModel(
      dailyCount: json['dailyCount'] != null
          ? VisitDailyCountModel.fromJson(json['dailyCount'] as Map<String, dynamic>)
          : null,
      weeklyCount: (json['weeklyCount'] as List?)
          ?.map((e) => VisitWeeklyCountModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productSoldWeekly: (json['productSoldWeekly'] as List?)
          ?.map((e) => ProductSoldWeeklyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitServiceWeekly: (json['unitServiceWeekly'] as List?)
          ?.map((e) => UnitServiceWeeklyModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rushHour: (json['rushHour'] as List?)
          ?.map((e) => VisitRushHourModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class VisitDailyCountModel extends VisitDailyCount {
  const VisitDailyCountModel({
    required super.totalVisit,
    required super.callIn,
    required super.chatIn,
    required super.walkIn,
    required super.unitServiced,
    required super.productSold,
  });

  factory VisitDailyCountModel.fromJson(Map<String, dynamic> json) {
    return VisitDailyCountModel(
      totalVisit: _int(json['total_visit']),
      callIn: _int(json['call_in']),
      chatIn: _int(json['chat_in']),
      walkIn: _int(json['walk_in']),
      unitServiced: _int(json['unit_serviced']),
      productSold: _int(json['product_sold']),
    );
  }
}

class VisitWeeklyCountModel extends VisitWeeklyCount {
  const VisitWeeklyCountModel({
    required super.date,
    required super.totalVisit,
  });

  factory VisitWeeklyCountModel.fromJson(Map<String, dynamic> json) {
    return VisitWeeklyCountModel(
      date: json['date'] as String? ?? '',
      totalVisit: _int(json['total_visit']),
    );
  }
}

class VisitRushHourModel extends VisitRushHour {
  const VisitRushHourModel({
    required super.hour,
    required super.totalVisit,
  });

  factory VisitRushHourModel.fromJson(Map<String, dynamic> json) {
    return VisitRushHourModel(
      hour: json['hour'] as String? ?? '',
      totalVisit: _int(json['total_visit']),
    );
  }
}

class ProductSoldWeeklyModel extends ProductSoldWeekly {
  const ProductSoldWeeklyModel({
    required super.date,
    required super.totalProductSold,
  });

  factory ProductSoldWeeklyModel.fromJson(Map<String, dynamic> json) {
    return ProductSoldWeeklyModel(
      date: json['date'] as String? ?? '',
      totalProductSold: _int(json['totalProductSold'] ?? json['total_product_sold']),
    );
  }
}

class UnitServiceWeeklyModel extends UnitServiceWeekly {
  const UnitServiceWeeklyModel({
    required super.date,
    required super.totalUnitService,
  });

  factory UnitServiceWeeklyModel.fromJson(Map<String, dynamic> json) {
    return UnitServiceWeeklyModel(
      date: json['date'] as String? ?? '',
      totalUnitService: _int(json['totalUnitService'] ?? json['total_unit_service']),
    );
  }
}
