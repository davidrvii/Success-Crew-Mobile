class VisitRequest {
  final int? userId;
  final int? visitorId;

  final String? visitorName;
  final String? visitorPhone;
  final String? visitorCompany;

  final String? purpose;
  final String? status;
  final String? visitorCategory;
  
  final String? visitType;
  final String? visitDesc;
  final DateTime? createdAt;
  final String? visitSales;

  const VisitRequest({
    this.userId,
    this.visitorId,
    this.visitorName,
    this.visitorPhone,
    this.visitorCompany,
    this.purpose,
    this.status,
    this.visitorCategory,
    this.visitType,
    this.visitDesc,
    this.createdAt,
    this.visitSales,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (userId != null) data['user_id'] = userId;
    if (visitorId != null) data['visitor_id'] = visitorId;
    if (visitorName != null) {
      data['visitor_name'] = visitorName;
      data['customer_name'] = visitorName;
    }
    if (visitorPhone != null) {
      data['visitor_phone'] = visitorPhone;
      data['customer_phone'] = visitorPhone;
    }
    if (visitorCompany != null) {
      data['visitor_company'] = visitorCompany;
    }
    if (purpose != null) {
      data['purpose'] = purpose;
      data['visitor_interest'] = purpose;
    }
    if (status != null) {
      data['status'] = status;
      data['visitor_status'] = status;
    }
    if (visitorCategory != null) {
      data['visitor_category'] = visitorCategory;
      data['visitory_category'] = visitorCategory;
      data['notes'] = visitorCategory;
    }
    if (visitType != null) data['visit_type'] = visitType;
    if (visitDesc != null) data['visit_desc'] = visitDesc;
    if (createdAt != null) data['created_at'] = createdAt!.toIso8601String();
    if (visitSales != null) {
      data['visit_sales'] = visitSales;
      data['sales_name'] = visitSales;
    }

    return data;
  }
}
