class FollowUp {
  final int followUpId;
  final int visitId;

  final String? stage;
  final String? status;
  final String? notes;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const FollowUp({
    required this.followUpId,
    required this.visitId,
    this.stage,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });
}
