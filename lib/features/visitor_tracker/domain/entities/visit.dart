class Visit {
  final int visitId;
  final int? visitorId;
  final int? userId;

  final String? visitorInterest;
  final String? visitorStatus;
  final String? visitType;
  final String? visitDesc;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Visit({
    required this.visitId,
    this.visitorId,
    this.userId,
    this.visitorInterest,
    this.visitorStatus,
    this.visitType,
    this.visitDesc,
    this.createdAt,
    this.updatedAt,
  });
}
