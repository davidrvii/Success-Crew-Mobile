class UserDetailDto {
  final int userId;
  final int? officeId;
  final int? roleId;

  final String userName;
  final String userEmail;
  final String? userPhoto;

  final String? roleName;
  final String? officeName;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserDetailDto({
    required this.userId,
    required this.officeId,
    required this.roleId,
    required this.userName,
    required this.userEmail,
    required this.userPhoto,
    required this.roleName,
    required this.officeName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserDetailDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDto(
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      officeId: (json['office_id'] as num?)?.toInt(),
      roleId: (json['role_id'] as num?)?.toInt(),
      userName: (json['user_name'] as String?) ?? '',
      userEmail: (json['user_email'] as String?) ?? '',
      userPhoto: json['user_photo']?.toString(),
      roleName: json['role_name'] as String?,
      officeName: json['office_name'] as String?,
      createdAt: _tryParseDate(json['created_at']),
      updatedAt: _tryParseDate(json['updated_at']),
    );
  }

  static DateTime? _tryParseDate(dynamic v) {
    if (v is String) return DateTime.tryParse(v);
    return null;
  }
}

class UserDetailResponse {
  final int statusCode;
  final String message;
  final UserDetailDto? userDetail;

  const UserDetailResponse({
    required this.statusCode,
    required this.message,
    required this.userDetail,
  });

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['userDetail'] ?? json['user'];
    return UserDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      userDetail: payload is Map<String, dynamic>
          ? UserDetailDto.fromJson(payload)
          : null,
    );
  }
}
