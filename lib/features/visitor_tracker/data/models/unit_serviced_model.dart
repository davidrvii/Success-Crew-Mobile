DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

class UnitServicedModel {
  final int unitServicedId;
  final int? visitId;

  final String? unitName;
  final String? issue;
  final String? action;
  final String? status;
  final String? notes;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UnitServicedModel({
    required this.unitServicedId,
    this.visitId,
    this.unitName,
    this.issue,
    this.action,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory UnitServicedModel.fromJson(Map<String, dynamic> json) {
    return UnitServicedModel(
      unitServicedId:
          _int(
            json['unit_serviced_id'] ?? json['unitServicedId'] ?? json['id'],
          ) ??
          0,
      visitId: _int(json['visit_id']),
      unitName: json['unit_name'] as String? ?? json['name'] as String?,
      issue: json['issue'] as String? ?? json['problem'] as String?,
      action: json['action'] as String? ?? json['solution'] as String?,
      status: json['status'] as String?,
      notes: json['notes'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
