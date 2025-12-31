class CheckInRequest {
  /// Optional, only if your backend supports it.
  final String? status;

  const CheckInRequest({this.status});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (status != null && status!.isNotEmpty) {
      map['status'] = status;
      map['attendance_status'] = status;
    }

    return map;
  }
}
