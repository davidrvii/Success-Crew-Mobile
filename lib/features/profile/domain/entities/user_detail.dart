class UserDetail {
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

  const UserDetail({
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
}
