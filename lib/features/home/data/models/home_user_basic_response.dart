class HomeUserBasicResponse {
  final int statusCode;
  final String message;
  final HomeUserBasicDto? userBasic;

  const HomeUserBasicResponse({
    required this.statusCode,
    required this.message,
    required this.userBasic,
  });

  factory HomeUserBasicResponse.fromJson(Map<String, dynamic> json) {
    final payload = _extractMap(
      json,
      preferredKeys: const ['userBasic', 'user_basic', 'user'],
    );
    return HomeUserBasicResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      userBasic: payload == null ? null : HomeUserBasicDto.fromJson(payload),
    );
  }
}

class HomeUserBasicDto {
  final int userId;
  final String userName;
  final String? userPhoto;
  final String? roleName;

  const HomeUserBasicDto({
    required this.userId,
    required this.userName,
    required this.userPhoto,
    required this.roleName,
  });

  factory HomeUserBasicDto.fromJson(Map<String, dynamic> json) {
    return HomeUserBasicDto(
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      userName: (json['user_name'] as String?) ?? '',
      userPhoto: json['user_photo'] as String?,
      roleName: json['role_name'] as String?,
    );
  }
}

Map<String, dynamic>? _extractMap(
  Map<String, dynamic> json, {
  required List<String> preferredKeys,
}) {
  for (final k in preferredKeys) {
    final v = json[k];
    if (v is Map<String, dynamic>) return v;
  }
  for (final entry in json.entries) {
    if (entry.key == 'statusCode' || entry.key == 'message') continue;
    if (entry.value is Map<String, dynamic>) {
      return entry.value as Map<String, dynamic>;
    }
  }
  return null;
}
