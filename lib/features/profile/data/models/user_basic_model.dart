class UserBasicDto {
  final int userId;
  final String userName;
  final String? userPhoto;
  final String? roleName;

  const UserBasicDto({
    required this.userId,
    required this.userName,
    required this.userPhoto,
    required this.roleName,
  });

  factory UserBasicDto.fromJson(Map<String, dynamic> json) {
    return UserBasicDto(
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      userName: (json['user_name'] as String?) ?? '',
      userPhoto: json['user_photo']?.toString(),
      roleName: json['role_name'] as String?,
    );
  }
}

class UserBasicResponse {
  final int statusCode;
  final String message;
  final UserBasicDto? userBasic;

  const UserBasicResponse({
    required this.statusCode,
    required this.message,
    required this.userBasic,
  });

  factory UserBasicResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['userBasic'];
    return UserBasicResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      userBasic: payload is Map<String, dynamic>
          ? UserBasicDto.fromJson(payload)
          : null,
    );
  }
}
