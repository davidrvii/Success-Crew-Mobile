import 'visitor_model.dart';

DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

class VisitModel {
  final int visitId;
  final int? visitorId;
  final int? userId;
  final VisitorModel? visitor;
  final String? visitorName;
  final String? visitorPhone;
  final String? visitorCompany;
  final String? visitorInformation;

  final String? visitorInterest;
  final String? visitorStatus;
  final String? visitType;
  final String? visitDesc;
  final String? salesName;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const VisitModel({
    required this.visitId,
    this.visitorId,
    this.userId,
    this.visitor,
    this.visitorName,
    this.visitorPhone,
    this.visitorCompany,
    this.visitorInformation,
    this.visitorInterest,
    this.visitorStatus,
    this.visitType,
    this.visitDesc,
    this.salesName,
    this.createdAt,
    this.updatedAt,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      visitId: _int(json['visit_id']) ?? 0,
      visitorId: _int(json['visitor_id']),
      userId: _int(json['user_id']),
      visitor: json['visitor'] != null
          ? VisitorModel.fromJson(json['visitor'] as Map<String, dynamic>)
          : null,
      visitorName: json['visitor_name'] as String?,
      visitorPhone: json['visitor_phone'] as String?,
      visitorCompany: json['visitor_company'] as String?,
      visitorInformation: json['visitor_information'] as String?,
      visitorInterest: json['visitor_interest'] as String?,
      visitorStatus: json['visitor_status'] as String?,
      visitType: json['visit_type'] as String?,
      visitDesc: json['visit_desc'] as String?,
      salesName: json['sales_name'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
