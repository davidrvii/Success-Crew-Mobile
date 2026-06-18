class OutOfOfficeRequest {
  final int? userId;
  final String? description;
  final String? date;
  final String? status;

  const OutOfOfficeRequest({
    this.userId,
    this.description,
    this.date,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (userId != null) {
      map['user_id'] = userId;
      map['userId'] = userId;
    }

    if (description != null && description!.isNotEmpty) {
      map['outofoffice_desc'] = description;
      map['out_of_office_desc'] = description;
      map['description'] = description;
    }

    if (date != null && date!.isNotEmpty) {
      map['outofoffice_date'] = date;
      map['out_of_office_date'] = date;
      map['date'] = date;
    }

    if (status != null && status!.isNotEmpty) {
      map['outofoffice_status'] = status;
      map['out_of_office_status'] = status;
      map['status'] = status;
    }

    return map;
  }
}
