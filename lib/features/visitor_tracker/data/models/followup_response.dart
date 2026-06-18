import 'followup_model.dart';

int _status(Map<String, dynamic> json) =>
    (json['statusCode'] as num?)?.toInt() ?? 0;
String _msg(Map<String, dynamic> json) => (json['message'] as String?) ?? '';

List<Map<String, dynamic>> _asListMap(dynamic raw) {
  if (raw is List) return raw.whereType<Map<String, dynamic>>().toList();
  if (raw is Map<String, dynamic>) {
    final inner =
        raw['followUps'] ?? raw['followups'] ?? raw['data'] ?? raw['items'];
    if (inner is List) return inner.whereType<Map<String, dynamic>>().toList();
  }
  return const <Map<String, dynamic>>[];
}

Map<String, dynamic>? _asMap(dynamic raw) =>
    raw is Map<String, dynamic> ? raw : null;

/// Response for GET /follow-up/all AND GET /follow-up/visit/:visitId
class FollowUpListResponse {
  final int statusCode;
  final String message;
  final List<FollowUpModel> followUps;

  const FollowUpListResponse({
    required this.statusCode,
    required this.message,
    required this.followUps,
  });

  factory FollowUpListResponse.fromJson(Map<String, dynamic> json) {
    final raw =
        json['followUps'] ??
        json['followupList'] ??
        json['data'] ??
        json['items'] ??
        json['result'];
    final list = _asListMap(raw).map(FollowUpModel.fromJson).toList();

    return FollowUpListResponse(
      statusCode: _status(json),
      message: _msg(json),
      followUps: list,
    );
  }
}

/// Response for POST /follow-up/add, POST /follow-up/visit/:visitId,
/// PUT /follow-up/update/:followUpId, PATCH /follow-up/visit/:visitId/:followUpId
class FollowUpMutationResponse {
  final int statusCode;
  final String message;
  final FollowUpModel? followUp;

  const FollowUpMutationResponse({
    required this.statusCode,
    required this.message,
    required this.followUp,
  });

  factory FollowUpMutationResponse.fromJson(Map<String, dynamic> json) {
    // Covers: followUpCreated (add), followUpUpdated (update),
    //         followUp (visit nested), newFollowUp, updatedFollowUp
    final raw =
        json['followUpCreated'] ??
        json['followUpUpdated'] ??
        json['followUp'] ??
        json['newFollowUp'] ??
        json['updatedFollowUp'] ??
        json['data'] ??
        json['result'];

    final map = _asMap(raw);

    return FollowUpMutationResponse(
      statusCode: _status(json),
      message: _msg(json),
      followUp: map == null ? null : FollowUpModel.fromJson(map),
    );
  }
}

/// Response for DELETE /follow-up/delete/:followUpId
/// and DELETE /follow-up/visit/:visitId/:followUpId
class FollowUpDeleteResponse {
  final int statusCode;
  final String message;
  final int? deletedId;

  const FollowUpDeleteResponse({
    required this.statusCode,
    required this.message,
    required this.deletedId,
  });

  factory FollowUpDeleteResponse.fromJson(Map<String, dynamic> json) {
    // API returns `followUpId` for non-nested delete
    // Visit nested delete only returns statusCode + message
    final rawId = json['followUpId'] ?? json['deletedId'] ?? json['id'];
    final id = (rawId is num) ? rawId.toInt() : int.tryParse('$rawId');

    return FollowUpDeleteResponse(
      statusCode: _status(json),
      message: _msg(json),
      deletedId: id,
    );
  }
}
