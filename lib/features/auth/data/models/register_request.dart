class RegisterRequest {
  final int officeId;
  final int roleId;
  final String userName;
  final String userEmail;
  final String userPassword;

  const RegisterRequest({
    required this.officeId,
    required this.roleId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
  });

  Map<String, dynamic> toJson() => {
    'office_id': officeId,
    'role_id': roleId,
    'user_name': userName,
    'user_email': userEmail,
    'user_password': userPassword,
  };
}
