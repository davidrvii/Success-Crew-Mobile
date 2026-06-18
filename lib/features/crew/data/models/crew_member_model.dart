class CrewMemberDto {
  final int userId;
  final String userName;
  final String userEmail;
  final String? userPhoto;
  final String roleName;
  final String officeName;

  const CrewMemberDto({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userPhoto,
    required this.roleName,
    required this.officeName,
  });

  factory CrewMemberDto.fromJson(Map<String, dynamic> json) {
    return CrewMemberDto(
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      userName: (json['user_name'] as String?) ?? '',
      userEmail: (json['user_email'] as String?) ?? '',
      userPhoto: json['user_photo'] as String?,
      roleName: (json['role_name'] as String?) ?? '',
      officeName: (json['office_name'] as String?) ?? '',
    );
  }
}

class CrewListResponse {
  final int statusCode;
  final String message;
  final List<CrewMemberDto> users;

  const CrewListResponse({
    required this.statusCode,
    required this.message,
    required this.users,
  });

  factory CrewListResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['users'] ?? json['crew']) as List?;
    final parsed = list
            ?.whereType<Map<String, dynamic>>()
            .map(CrewMemberDto.fromJson)
            .toList() ??
        const <CrewMemberDto>[];

    return CrewListResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      users: parsed,
    );
  }
}
