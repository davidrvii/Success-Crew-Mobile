import 'visitor.dart';
import 'followup.dart';
import 'product_sold.dart';
import 'unit_serviced.dart';

class Visit {
  final int visitId;
  final int? visitorId;
  final int? userId;
  final Visitor? visitor;

  final String? visitorName;
  final String? visitorPhone;
  final String? visitorCompany;
  final String? visitorInformation;
  final String? visitorCategory;

  final String? visitorInterest;
  final String? visitorStatus;
  final String? visitType;
  final String? visitDesc;
  final String? salesName;

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
    this.visitorInformation,
    this.visitorCategory,
    this.visitorInterest,
    this.visitorStatus,
    this.visitType,
    this.visitDesc,
    this.salesName,
    this.createdAt,
    this.updatedAt,
    this.followUps,
    this.productsSold,
    this.unitsServiced,
  });
}
