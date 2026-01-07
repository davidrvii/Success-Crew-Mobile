class Visit {
  final int visitId;
  final int? userId;

  final String? customerName;
  final String? customerPhone;
  final String? customerAddress;

  final String? purpose;
  final String? status;
  final String? notes;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Visit({
    required this.visitId,
    this.userId,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.purpose,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });
}
