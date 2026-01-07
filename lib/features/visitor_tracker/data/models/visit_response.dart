import 'visit_model.dart';

int _status(Map<String, dynamic> json) =>
    (json['statusCode'] as num?)?.toInt() ?? 0;
String _msg(Map<String, dynamic> json) => (json['message'] as String?) ?? '';

List<Map<String, dynamic>> _asListMap(dynamic raw) {
  if (raw is List) {
    return raw.whereType<Map<String, dynamic>>().toList();
  }
  if (raw is Map<String, dynamic>) {
    final inner = raw['visits'] ?? raw['data'] ?? raw['items'];
    if (inner is List) {
      return inner.whereType<Map<String, dynamic>>().toList();
    }
  }
  return const <Map<String, dynamic>>[];
}

Map<String, dynamic>? _asMap(dynamic raw) =>
    raw is Map<String, dynamic> ? raw : null;

class VisitListResponse {
  final int statusCode;
  final String message;
  final List<VisitModel> visits;

  const VisitListResponse({
    required this.statusCode,
    required this.message,
    required this.visits,
  });

  factory VisitListResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['visits'] ??
        json['visitList'] ??
        json['data'] ??
        json['result'] ??
        json['items'];
    final list = _asListMap(raw).map(VisitModel.fromJson).toList();

    return VisitListResponse(
      statusCode: _status(json),
      message: _msg(json),
      visits: list,
    );
  }
}

class VisitDetailResponse {
  final int statusCode;
  final String message;
  final VisitModel? visitDetail;

  const VisitDetailResponse({
    required this.statusCode,
    required this.message,
    required this.visitDetail,
  });

  factory VisitDetailResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['visitDetail'] ??
        json['visit'] ??
        json['detail'] ??
        json['data'] ??
        json['result'];
    final map = _asMap(raw);

    return VisitDetailResponse(
      statusCode: _status(json),
      message: _msg(json),
      visitDetail: map == null ? null : VisitModel.fromJson(map),
    );
  }
}

class VisitMutationResponse {
  final int statusCode;
  final String message;
  final VisitModel? visit;

  const VisitMutationResponse({
    required this.statusCode,
    required this.message,
    required this.visit,
  });

  factory VisitMutationResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['visit'] ??
        json['newVisit'] ??
        json['visitCreated'] ??
        json['updatedVisit'] ??
        json['visitUpdated'] ??
        json['visitDetail'] ??
        json['data'] ??
        json['result'];

    final map = _asMap(raw);

    return VisitMutationResponse(
      statusCode: _status(json),
      message: _msg(json),
      visit: map == null ? null : VisitModel.fromJson(map),
    );
  }
}

class VisitDeleteResponse {
  final int statusCode;
  final String message;
  final int? deletedId;

  const VisitDeleteResponse({
    required this.statusCode,
    required this.message,
    required this.deletedId,
  });

  factory VisitDeleteResponse.fromJson(Map<String, dynamic> json) {
    final rawId = json['visitId'] ?? json['deletedId'] ?? json['id'];
    final id = (rawId is num) ? rawId.toInt() : int.tryParse('$rawId');

    return VisitDeleteResponse(
      statusCode: _status(json),
      message: _msg(json),
      deletedId: id,
    );
  }
}
