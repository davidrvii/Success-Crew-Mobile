class HomeVisitSummaryResponse {
  final int visitorsToday;

  HomeVisitSummaryResponse({required this.visitorsToday});

  factory HomeVisitSummaryResponse.fromJson(Map<String, dynamic> json) {
    return HomeVisitSummaryResponse(
      visitorsToday: json['visitors_today'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'visitors_today': visitorsToday};
  }
}
