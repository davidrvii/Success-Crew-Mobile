DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

class VisitModel {
  final int visitId;
  final int? visitorId;
  final int? userId;

  final String? visitorInterest;
  final String? visitorStatus;
  final String? visitType;
  final String? visitDesc;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const VisitModel({
    required this.visitId,
    this.visitorId,
    this.userId,
    this.visitorInterest,
    this.visitorStatus,
    this.visitType,
    this.visitDesc,
    this.createdAt,
    this.updatedAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      visitId: _int(json['visit_id']) ?? 0,
      visitorId: _int(json['visitor_id']),
      userId: _int(json['user_id']),
      visitorInterest: json['visitor_interest'] as String?,
      visitorStatus: json['visitor_status'] as String?,
      visitType: json['visit_type'] as String?,
      visitDesc: json['visit_desc'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
