/// File: lib/features/visitor_tracker/data/models/unit_serviced_model.dart
/// Generated Documentation for unit_serviced_model.dart

DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

/// Class representing `UnitServicedModel`.
/// Auto-generated class documentation.
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
      unitName: json['unit_serviced_name'] as String? ?? json['unit_serviced_type'] as String? ?? json['unit_name'] as String? ?? json['name'] as String?,
      issue: json['unit_serviced_issue'] as String? ?? json['issue'] as String? ?? json['problem'] as String?,
      action: json['unit_serviced_action'] as String? ?? json['action'] as String? ?? json['solution'] as String?,
      status: json['unit_serviced_status'] as String? ?? json['status'] as String?,
      notes: json['unit_serviced_desc'] as String? ?? json['unit_serviced_category'] as String? ?? json['notes'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
