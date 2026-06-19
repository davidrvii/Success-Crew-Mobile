/// File: lib/features/visitor_tracker/data/models/visitor_request.dart
/// Generated Documentation for visitor_request.dart

/// Class representing `VisitorRequest`.
/// Auto-generated class documentation.
class VisitorRequest {
  final String visitorName;
  final String visitorPhone;
  final String visitorCompany;
  final String visitorCategory;

  const VisitorRequest({
    required this.visitorName,
    required this.visitorPhone,
    required this.visitorCompany,
    required this.visitorCategory,
  });

  Map<String, dynamic> toJson() {
    return {
      'visitor_name': visitorName,
      'visitor_phone': visitorPhone,
      'visitor_company': visitorCompany,
      'visitor_category': visitorCategory,
    };
  }
}
