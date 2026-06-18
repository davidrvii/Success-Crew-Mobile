class RegisterResponse {
  final int statusCode;
  final String message;
  final UserRegistered? userRegistered;

  const RegisterResponse({
    required this.statusCode,
    required this.message,
    required this.userRegistered,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      userRegistered: json['userRegistered'] == null
          ? null
          : UserRegistered.fromJson(
              json['userRegistered'] as Map<String, dynamic>,
            ),
    );
  }
}

class UserRegistered {
  final int userId;
  final int officeId;
  final int roleId;
  final String userName;
  final String userEmail;
  final DateTime? createdAt;
  final String? userPhone;
  final DateTime? userBirth;
  final DateTime? startWork;
  final DateTime? endWork;
  final String? crewStatus;
  final String? contractStatus;

  const UserRegistered({
    required this.userId,
    required this.officeId,
    required this.roleId,
    required this.userName,
    required this.userEmail,
    required this.createdAt,
    this.userPhone,
    this.userBirth,
    this.startWork,
    this.endWork,
    this.crewStatus,
    this.contractStatus,
  });

  factory UserRegistered.fromJson(Map<String, dynamic> json) {
    return UserRegistered(
      userId: (json['user_id'] as num).toInt(),
      officeId: (json['office_id'] as num).toInt(),
      roleId: (json['role_id'] as num).toInt(),
      userName: (json['user_name'] as String?) ?? '',
      userEmail: (json['user_email'] as String?) ?? '',
      createdAt: _tryParseDate(json['created_at']),
      userPhone: json['user_phone'] as String?,
      userBirth: _tryParseDate(json['user_birth']),
      startWork: _tryParseDate(json['start_work']),
      endWork: _tryParseDate(json['end_work']),
      crewStatus: json['crew_status'] as String?,
      contractStatus: json['contract_status'] as String?,
    );
  }

  static DateTime? _tryParseDate(dynamic v) {
    if (v is String && v.isNotEmpty) {
      try {
        return DateTime.parse(v);
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
