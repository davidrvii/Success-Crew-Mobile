import 'visitor_model.dart';

int _status(Map<String, dynamic> json) =>
    (json['statusCode'] as num?)?.toInt() ?? 0;
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
