class RegisteredUser {
  final int userId;
  final int officeId;
  final int roleId;
  final String userName;
  final String userEmail;

  const RegisteredUser({
    required this.userId,
    required this.officeId,
    required this.roleId,
    required this.userName,
    required this.userEmail,
  });
}
