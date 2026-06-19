/// File: lib/features/visitor_tracker/domain/entities/visitor.dart
/// Generated Documentation for visitor.dart

import 'visit.dart';

/// Class representing `Visitor`.
/// Auto-generated class documentation.
class Visitor {
  final int visitorId;
  final String? visitorName;
  final String? visitorPhone;
  final String? visitorCompany;
  final String? visitorCategory;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Visit>? visits;

  const Visitor({
    required this.visitorId,
    this.visitorName,
    this.visitorPhone,
    this.visitorCompany,
    this.visitorCategory,
    this.createdAt,
    this.updatedAt,
    this.visits,
  });
}
