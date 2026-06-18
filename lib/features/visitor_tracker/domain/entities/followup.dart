class FollowUp {
  final int followUpId;
  final int? visitId;

  /// Status follow-up (e.g. "CONTACTED", "DONE")
  final String? followUpStatus;
  /// Action / note for this follow-up
  final String? followUpAction;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FollowUp({
    required this.followUpId,
    this.visitId,
    this.followUpStatus,
    this.followUpAction,
    this.createdAt,
    this.updatedAt,
  });

  /// Backward-compatible alias for followUpStatus
  String? get status => followUpStatus;

  /// Backward-compatible alias for followUpAction
  String? get notes => followUpAction;
}
