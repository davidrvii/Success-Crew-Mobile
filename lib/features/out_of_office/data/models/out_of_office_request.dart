/// File: lib/features/out_of_office/data/models/out_of_office_request.dart
/// Generated Documentation for out_of_office_request.dart

/// Class representing `OutOfOfficeRequest`.
/// Auto-generated class documentation.
class OutOfOfficeRequest {
  final int? userId;
  final String? description;
  final String? startDate;
  final String? endDate;
  final String? status;

  const OutOfOfficeRequest({
    this.userId,
    this.description,
    this.startDate,
    this.endDate,
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

    if (startDate != null && startDate!.isNotEmpty) {
      map['outofoffice_start'] = startDate;
      map['out_of_office_start'] = startDate;
    }

    if (endDate != null && endDate!.isNotEmpty) {
      map['outofoffice_end'] = endDate;
      map['out_of_office_end'] = endDate;
    }

    if (status != null && status!.isNotEmpty) {
      map['outofoffice_status'] = status;
      map['out_of_office_status'] = status;
      map['status'] = status;
    }

    return map;
  }
}
