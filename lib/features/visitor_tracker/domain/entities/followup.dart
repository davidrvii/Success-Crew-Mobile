/// File: lib/features/visitor_tracker/domain/entities/followup.dart
/// Generated Documentation for followup.dart

/// Class representing `FollowUp`.
/// Auto-generated class documentation.
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
  /// Getter for `status` returning `String?`.
  String? get status => followUpStatus;

  /// Backward-compatible alias for followUpAction
  /// Getter for `notes` returning `String?`.
  String? get notes => followUpAction;
}
