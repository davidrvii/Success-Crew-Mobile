/// File: lib/features/visitor_tracker/data/models/followup_request.dart
/// Generated Documentation for followup_request.dart

/// Class representing `FollowUpRequest`.
/// Auto-generated class documentation.
class FollowUpRequest {
  /// `visit_id` — used for non-nested add endpoint `/follow-up/add`
  final int? visitId;

  /// `follow_up_status` — e.g. "CONTACTED", "DONE"
  final String? followUpStatus;

  /// `follow_up_action` — e.g. "WA customer untuk penawaran"
  final String? followUpAction;

  const FollowUpRequest({
    this.visitId,
    this.followUpStatus,
    this.followUpAction,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};

    if (visitId != null) data['visit_id'] = visitId;
    if (followUpStatus != null) data['follow_up_status'] = followUpStatus;
    if (followUpAction != null) data['follow_up_action'] = followUpAction;

    return data;
  }
}
