/// File: lib/features/visitor_tracker/data/models/followup_model.dart
/// Generated Documentation for followup_model.dart

DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

/// Class representing `FollowUpModel`.
/// Auto-generated class documentation.
class FollowUpModel {
  final int followUpId;
  final int? visitId;

  /// `follow_up_status` 
  final String? followUpStatus;

  /// `follow_up_action` 
  final String? followUpAction;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FollowUpModel({
    required this.followUpId,
    this.visitId,
    this.followUpStatus,
    this.followUpAction,
    this.createdAt,
    this.updatedAt,
  });

  factory FollowUpModel.fromJson(Map<String, dynamic> json) {
    return FollowUpModel(
      followUpId:
          _int(json['follow_up_id'] ?? json['followUpId'] ?? json['id']) ?? 0,
      visitId: _int(json['visit_id'] ?? json['visitId']),
      followUpStatus:
          json['follow_up_status'] as String? ?? json['status'] as String?,
      followUpAction:
          json['follow_up_action'] as String? ?? json['action'] as String?,
      createdAt: _dt(json['created_at'] ?? json['createdAt']),
      updatedAt: _dt(json['updated_at'] ?? json['updatedAt']),
    );
  }
}
