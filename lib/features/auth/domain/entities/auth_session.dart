/// File: lib/features/auth/domain/entities/auth_session.dart
/// Generated Documentation for auth_session.dart

/// Class representing `AuthSession`.
/// Auto-generated class documentation.
class AuthSession {
  final int userId;
  final String userName;
  final String userEmail;

  final int? roleId;
  final String? roleName;

  final int? officeId;
  final String? officeName;

  final String token;

  const AuthSession({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.roleId,
    required this.roleName,
    required this.officeId,
    required this.officeName,
    required this.token,
  });
}
