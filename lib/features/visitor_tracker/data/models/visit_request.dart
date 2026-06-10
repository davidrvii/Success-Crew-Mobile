class VisitRequest {
  final int? userId;
  final int? visitorId;

  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;

  final String? purpose;
  final String? status;
  final String? notes;
  
  final String? visitType;
  final String? visitDesc;
  final DateTime? createdAt;

  const VisitRequest({
    this.userId,
    this.visitorId,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.purpose,
    this.status,
    this.notes,
    this.visitType,
    this.visitDesc,
    this.createdAt,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (userId != null) data['user_id'] = userId;
    if (visitorId != null) data['visitor_id'] = visitorId;
    if (customerName != null) data['customer_name'] = customerName;
    if (customerPhone != null) data['customer_phone'] = customerPhone;
    if (customerAddress != null) data['customer_address'] = customerAddress;
    if (purpose != null) data['purpose'] = purpose;
    if (status != null) data['status'] = status;
    if (notes != null) data['notes'] = notes;
    if (visitType != null) data['visit_type'] = visitType;
    if (visitDesc != null) data['visit_desc'] = visitDesc;
    if (createdAt != null) data['created_at'] = createdAt!.toIso8601String();

    if (purpose != null) data['visitor_interest'] = purpose;
    if (status != null) data['visitor_status'] = status;

    if (customerName != null) data['visitor_name'] = customerName;
    if (customerPhone != null) data['visitor_phone'] = customerPhone;
    if (customerAddress != null) data['visitor_address'] = customerAddress;
    if (notes != null) data['visitor_information'] = notes;

    return data;
  }
}
