DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

class VisitModel {
  final int visitId;
  final int? userId;

  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;

  final String? purpose;
  final String? status;
  final String? notes;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const VisitModel({
    required this.visitId,
    this.userId,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.purpose,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      visitId: _int(json['visit_id'] ?? json['id']) ?? 0,
      userId: _int(json['user_id']),
      customerName: json['customer_name'] as String?,
      customerPhone: json['customer_phone'] as String?,
      customerAddress: json['customer_address'] as String?,
      purpose: json['purpose'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
