/// File: lib/features/visitor_tracker/domain/entities/unit_serviced.dart
/// Generated Documentation for unit_serviced.dart

/// Class representing `UnitServiced`.
/// Auto-generated class documentation.
class UnitServiced {
  final int unitServicedId;
  final int visitId;

  final String? unitName;
  final String? issue;
  final String? action;
  final String? status;
  final String? notes;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UnitServiced({
    required this.unitServicedId,
    required this.visitId,
    this.unitName,
    this.issue,
    this.action,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });
}
