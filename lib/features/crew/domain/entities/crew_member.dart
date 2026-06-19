/// File: lib/features/crew/domain/entities/crew_member.dart
/// Generated Documentation for crew_member.dart

/// Class representing `CrewMember`.
/// Auto-generated class documentation.
class CrewMember {
  final int userId;
  final String userName;
  final String userEmail;
  final String? userPhoto;
  final String roleName;
  final String officeName;

  const CrewMember({
    required this.userId,
    required this.userName,
    required this.userEmail,
    this.userPhoto,
    required this.roleName,
    required this.officeName,
  });
}
