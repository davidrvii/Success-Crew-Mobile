/// File: lib/features/visitor_tracker/data/models/visitor_response.dart
/// Generated Documentation for visitor_response.dart

import 'visitor_model.dart';

/// Method `_status` returning `int`.
/// Handles logic operations related to `_status`.
int _status(Map<String, dynamic> json) =>
    (json['statusCode'] as num?)?.toInt() ?? 0;
/// Method `_msg` returning `String`.
/// Handles logic operations related to `_msg`.
String _msg(Map<String, dynamic> json) => (json['message'] as String?) ?? '';

List<Map<String, dynamic>> _asListMap(dynamic raw) {
  if (raw is List) {
    return raw.whereType<Map<String, dynamic>>().toList();
  }
  if (raw is Map<String, dynamic>) {
    final inner = raw['visitors'] ?? raw['data'] ?? raw['items'];
    if (inner is List) {
      return inner.whereType<Map<String, dynamic>>().toList();
    }
  }
  return const <Map<String, dynamic>>[];
}

/// Class representing `VisitorListResponse`.
/// Auto-generated class documentation.
class VisitorListResponse {
  final int statusCode;
  final String message;
  final List<VisitorModel> visitors;

  const VisitorListResponse({
    required this.statusCode,
    required this.message,
    required this.visitors,
  });

  factory VisitorListResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['visitors'] ??
        json['visitorList'] ??
        json['data'] ??
        json['result'] ??
        json['items'];
    final list = _asListMap(raw).map(VisitorModel.fromJson).toList();

    return VisitorListResponse(
      statusCode: _status(json),
      message: _msg(json),
      visitors: list,
    );
  }
}

/// Class representing `VisitorDetailResponse`.
/// Auto-generated class documentation.
class VisitorDetailResponse {
  final int statusCode;
  final String message;
  final VisitorModel? visitor;

  const VisitorDetailResponse({
    required this.statusCode,
    required this.message,
    this.visitor,
  });

  factory VisitorDetailResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['visitor'] ?? json['data'] ?? json['detail'] ?? json['result'];
    final map = raw is Map<String, dynamic> ? raw : null;

    return VisitorDetailResponse(
      statusCode: _status(json),
      message: _msg(json),
      visitor: map != null ? VisitorModel.fromJson(map) : null,
    );
  }
}

/// Class representing `VisitorMutationResponse`.
/// Auto-generated class documentation.
class VisitorMutationResponse {
  final int statusCode;
  final String message;
  final VisitorModel? visitor;

  const VisitorMutationResponse({
    required this.statusCode,
    required this.message,
    this.visitor,
  });

  factory VisitorMutationResponse.fromJson(Map<String, dynamic> json) {
    final raw = json['visitor'] ?? json['visitorUpdated'] ?? json['data'] ?? json['result'];
    final map = raw is Map<String, dynamic> ? raw : null;

    return VisitorMutationResponse(
      statusCode: _status(json),
      message: _msg(json),
      visitor: map != null ? VisitorModel.fromJson(map) : null,
    );
  }
}

/// Class representing `VisitorDeleteResponse`.
/// Auto-generated class documentation.
class VisitorDeleteResponse {
  final int statusCode;
  final String message;
  final int? deletedId;

  const VisitorDeleteResponse({
    required this.statusCode,
    required this.message,
    this.deletedId,
  });

  factory VisitorDeleteResponse.fromJson(Map<String, dynamic> json) {
    final rawId = json['visitorId'] ?? json['deletedId'] ?? json['id'];
    final id = rawId is num ? rawId.toInt() : int.tryParse('$rawId');

    return VisitorDeleteResponse(
      statusCode: _status(json),
      message: _msg(json),
      deletedId: id,
    );
  }
}
