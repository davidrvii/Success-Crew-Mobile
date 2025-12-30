class LoginResponse {
  final int statusCode;
  final String message;
  final LoginResult? loginResult;

  const LoginResponse({
    required this.statusCode,
    required this.message,
    required this.loginResult,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      loginResult: json['loginResult'] == null
          ? null
          : LoginResult.fromJson(json['loginResult'] as Map<String, dynamic>),
    );
  }
}

class LoginResult {
  final int userId;
  final String userName;
  final String userEmail;

  final int? roleId;
  final String? roleName;

  final int? officeId;
  final String? officeName;

  final String token;

  const LoginResult({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.roleId,
    required this.roleName,
    required this.officeId,
    required this.officeName,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
      userId: (json['user_id'] as num).toInt(),
      userName: (json['user_name'] as String?) ?? '',
      userEmail: (json['user_email'] as String?) ?? '',
      roleId: (json['role_id'] as num?)?.toInt(),
      roleName: json['role_name'] as String?,
      officeId: (json['office_id'] as num?)?.toInt(),
      officeName: json['office_name'] as String?,
      token: (json['token'] as String?) ?? '',
    );
  }
}
