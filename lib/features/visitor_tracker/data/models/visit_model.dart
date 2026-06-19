/// File: lib/features/visitor_tracker/data/models/visit_model.dart
/// Generated Documentation for visit_model.dart

import 'visitor_model.dart';
import 'followup_model.dart';
import 'product_sold_model.dart';
import 'unit_serviced_model.dart';

DateTime? _dt(dynamic v) => v is String ? DateTime.tryParse(v) : null;
int? _int(dynamic v) => (v is num) ? v.toInt() : int.tryParse('$v');

/// Class representing `VisitModel`.
/// Auto-generated class documentation.
class VisitModel {
  final int visitId;
  final int? visitorId;
  final int? userId;
  final VisitorModel? visitor;
  final String? visitorName;
  final String? visitorPhone;
  final String? visitorCompany;
  final String? visitorCategory;

  final String? visitorInterest;
  final String? visitorStatus;
  final String? visitType;
  final String? visitDesc;
  final String? visitSales;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  final List<FollowUpModel>? followUps;
  final List<ProductSoldModel>? productsSold;
  final List<UnitServicedModel>? unitsServiced;

  const VisitModel({
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
    this.visitDesc,
    this.visitSales,
    this.createdAt,
    this.updatedAt,
    this.followUps,
    this.productsSold,
    this.unitsServiced,
  });

  factory VisitModel.fromJson(Map<String, dynamic> json) {
    return VisitModel(
      visitId: _int(json['visit_id'] ?? json['visitId']) ?? 0,
      visitorId: _int(json['visitor_id'] ?? json['visitorId']),
      userId: _int(json['user_id'] ?? json['userId']),
      visitor: json['visitor'] != null
          ? VisitorModel.fromJson(json['visitor'] as Map<String, dynamic>)
          : null,
      visitorName: json['visitor_name'] as String?,
      visitorPhone: json['visitor_phone'] as String?,
      visitorCompany: json['visitor_company'] as String?,
      visitorCategory: json['visitor_category'] as String? ?? json['visitory_category'] as String?,
      visitorInterest: json['visitor_interest'] as String? ?? json['visit_interest'] as String? ?? json['interest'] as String?,
      visitorStatus: json['visitor_status'] as String? ?? json['visit_status'] as String?,
      visitType: json['visit_type'] as String?,
      visitDesc: json['visit_desc'] as String?,
      visitSales: json['visit_sales'] as String? ?? json['sales_name'] as String? ?? json['user_name'] as String?,
      createdAt: _dt(json['created_at']),
      updatedAt: _dt(json['updated_at']),
      followUps: (json['Follow UP'] as List?)
          ?.map((e) => FollowUpModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      productsSold: (json['Product Sold'] as List?)
          ?.map((e) => ProductSoldModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unitsServiced: (json['Unit Serviced'] as List?)
          ?.map((e) => UnitServicedModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
