class CheckOutRequest {
  final String? status;

  const CheckOutRequest({this.status});

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (status != null && status!.isNotEmpty) {
      map['status'] = status;
      map['attendance_status'] = status;
    }

    return map;
  }
}
