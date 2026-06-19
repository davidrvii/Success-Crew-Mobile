import '../../domain/entities/visitor.dart';
import 'visit_model.dart';

DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

class VisitorModel extends Visitor {
  final List<VisitModel>? visitsModel;

  const VisitorModel({
    required super.visitorId,
    super.visitorName,
    super.visitorPhone,
    super.visitorCompany,
    super.visitorCategory,
    super.createdAt,
    super.updatedAt,
    super.visits,
    this.visitsModel,
  });

  factory VisitorModel.fromJson(Map<String, dynamic> json) {
    final rawVisits = (json['visit'] as List?)
        ?.map((e) => VisitModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return VisitorModel(
      visitorId: _int(json['visitor_id'] ?? json['visitorId']) ?? 0,
      visitorName: json['visitor_name'] as String?,
      visitorPhone: json['visitor_phone'] as String?,
      visitorCompany: json['visitor_company'] as String?,
      visitorCategory: json['visitor_category'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
      visitsModel: rawVisits,
    );
  }
}
