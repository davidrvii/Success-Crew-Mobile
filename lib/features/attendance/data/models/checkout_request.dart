/// File: lib/features/attendance/data/models/checkout_request.dart
/// Generated Documentation for checkout_request.dart

/// Request for PATCH /attendance/checkout
/// Body: { date: "YYYY-MM-DD" }
/// Class representing `CheckOutRequest`.
/// Auto-generated class documentation.
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
