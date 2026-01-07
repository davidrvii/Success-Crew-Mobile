class VisitRequest {
  final int? userId;
  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;
  final String? purpose;
  final String? status;
  final String? notes;

  const VisitRequest({
    this.userId,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.purpose,
    this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (userId != null) data['user_id'] = userId;
    if (customerName != null) data['customer_name'] = customerName;
    if (customerPhone != null) data['customer_phone'] = customerPhone;
    if (customerAddress != null) data['customer_address'] = customerAddress;
    if (purpose != null) data['purpose'] = purpose;
    if (status != null) data['status'] = status;
    if (notes != null) data['notes'] = notes;

    return data;
  }
}
