import 'unit_serviced_model.dart';

int _status(Map<String, dynamic> json) =>
    (json['statusCode'] as num?)?.toInt() ?? 0;
String _msg(Map<String, dynamic> json) => (json['message'] as String?) ?? '';

List<Map<String, dynamic>> _asListMap(dynamic raw) {
  if (raw is List) return raw.whereType<Map<String, dynamic>>().toList();
  if (raw is Map<String, dynamic>) {
    final inner =
        raw['unitsServiced'] ??
        raw['unitServiced'] ??
        raw['data'] ??
        raw['items'];
    if (inner is List) return inner.whereType<Map<String, dynamic>>().toList();
  }
  return const <Map<String, dynamic>>[];
}

Map<String, dynamic>? _asMap(dynamic raw) =>
    raw is Map<String, dynamic> ? raw : null;

class UnitServicedListResponse {
  final int statusCode;
  final String message;
  final List<UnitServicedModel> unitsServiced;

  const UnitServicedListResponse({
    required this.statusCode,
    required this.message,
    required this.unitsServiced,
  });

  factory UnitServicedListResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['unitsServiced'] ??
        json['data'] ??
        json['items'] ??
        json['result'];
    final list = _asListMap(raw).map(UnitServicedModel.fromJson).toList();

    return UnitServicedListResponse(
      statusCode: _status(json),
      message: _msg(json),
      unitsServiced: list,
    );
  }
}

class UnitServicedMutationResponse {
  final int statusCode;
  final String message;
  final UnitServicedModel? unitServiced;

  const UnitServicedMutationResponse({
    required this.statusCode,
    required this.message,
    required this.unitServiced,
  });

  factory UnitServicedMutationResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['unitServiced'] ??
        json['newUnitServiced'] ??
        json['updatedUnitServiced'] ??
        json['data'] ??
        json['result'];

    final map = _asMap(raw);

    return UnitServicedMutationResponse(
      statusCode: _status(json),
      message: _msg(json),
      unitServiced: map == null ? null : UnitServicedModel.fromJson(map),
    );
  }
}

class UnitServicedDeleteResponse {
  final int statusCode;
  final String message;
  final int? deletedId;

  const UnitServicedDeleteResponse({
    required this.statusCode,
    required this.message,
    required this.deletedId,
  });

  factory UnitServicedDeleteResponse.fromJson(Map<String, dynamic> json) {
    final rawId = json['unitServicedId'] ?? json['deletedId'] ?? json['id'];
    final id = (rawId is num) ? rawId.toInt() : int.tryParse('$rawId');

    return UnitServicedDeleteResponse(
      statusCode: _status(json),
      message: _msg(json),
      deletedId: id,
    );
  }
}
