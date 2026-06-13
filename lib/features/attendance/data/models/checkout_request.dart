class CheckOutRequest {
  final DateTime? checkOutAt;
  final DateTime? checkInAt;
  final String? status;

  const CheckOutRequest({
    this.checkOutAt,
    this.checkInAt,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (checkOutAt != null) {
      map['attendance_out'] = checkOutAt!.toUtc().toIso8601String();
    }
    if (checkInAt != null) {
      map['attendance_in'] = checkInAt!.toUtc().toIso8601String();
    }
    if (status != null && status!.isNotEmpty) {
      map['attendance_status'] = status;
    }

    return map;
  }
}
