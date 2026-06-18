/// Request for PATCH /attendance/checkout
/// Body: { date: "YYYY-MM-DD" }
class CheckOutRequest {
  /// Date string formatted as YYYY-MM-DD
  final String? date;

  const CheckOutRequest({this.date});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (date != null && date!.isNotEmpty) map['date'] = date;
    return map;
  }
}
