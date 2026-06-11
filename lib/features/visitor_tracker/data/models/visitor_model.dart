import '../../domain/entities/visitor.dart';

DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

class VisitorModel extends Visitor {
  const VisitorModel({
    required super.visitorId,
    super.visitorName,
    super.visitorPhone,
    super.visitorInformation,
    super.visitorCompany,
    super.createdAt,
    super.updatedAt,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    return VisitorModel(
      visitorId: _int(json['visitor_id']) ?? 0,
      visitorName: json['visitor_name'] as String?,
      visitorPhone: json['visitor_phone'] as String?,
      visitorInformation: json['visitor_information'] as String?,
      visitorCompany: json['visitor_company'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
