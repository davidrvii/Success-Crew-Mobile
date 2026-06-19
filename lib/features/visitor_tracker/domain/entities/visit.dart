/// File: lib/features/visitor_tracker/domain/entities/visit.dart
/// Generated Documentation for visit.dart

import 'visitor.dart';
import 'followup.dart';
import 'product_sold.dart';
import 'unit_serviced.dart';

/// Class representing `Visit`.
/// Auto-generated class documentation.
class Visit {
  final int visitId;
  final int? visitorId;
  final int? userId;
  final Visitor? visitor;

  final String? visitorName;
  final String? visitorPhone;
  final String? visitorCompany;
  final String? visitorCategory;

  final String? visitorInterest;
  final String? visitorStatus;
  final String? visitType;
  final String? visitSales;
  final String? visitDesc;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final List<FollowUp>? followUps;
  final List<ProductSold>? productsSold;
  final List<UnitServiced>? unitsServiced;

  const Visit({
    required this.visitId,
    this.visitorId,
    this.userId,
    this.visitor,
    this.visitorName,
    this.visitorPhone,
    this.visitorCompany,
    this.visitorCategory,
    this.visitorInterest,
    this.visitorStatus,
    this.visitType,
    this.visitSales,
    this.visitDesc,
    this.createdAt,
    this.updatedAt,
    this.followUps,
    this.productsSold,
    this.unitsServiced,
  });
}
