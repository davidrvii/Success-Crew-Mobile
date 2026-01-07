DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

class FollowUpModel {
  final int followUpId;
  final int? visitId;

  final String? stage;
  final String? notes;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FollowUpModel({
    required this.followUpId,
    this.visitId,
    this.stage,
    this.notes,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowUpModel.fromJson(Map<String, dynamic> json) {
    return FollowUpModel(
      followUpId:
          _int(json['follow_up_id'] ?? json['followUpId'] ?? json['id']) ?? 0,
      visitId: _int(json['visit_id']),
      stage: json['stage'] as String? ?? json['step'] as String?,
      notes: json['notes'] as String?,
      status: json['status'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
    );
  }
}
