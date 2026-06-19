/// File: lib/features/crew/data/models/crew_request.dart
/// Generated Documentation for crew_request.dart

/// Class representing `CrewRequest`.
/// Auto-generated class documentation.
class CrewRequest {
  final String? userName;
  final String? crewStatus;
  final String? contractStatus;
  final String? userEmail;
  final String? userPhone;
  final String? userBirth; // YYYY-MM-DD
  final String? startWork; // YYYY-MM-DD
  final String? endWork;   // YYYY-MM-DD
  final String? roleName;
  final String? officeName;
  final String? userPassword;

  const CrewRequest({
    this.userName,
    this.crewStatus,
    this.contractStatus,
    this.userEmail,
    this.userPhone,
    this.userBirth,
    this.startWork,
    this.endWork,
    this.roleName,
    this.officeName,
    this.userPassword,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (userName != null) map['user_name'] = userName;
    if (crewStatus != null) map['crew_status'] = crewStatus;
    if (contractStatus != null) map['contract_status'] = contractStatus;
    if (userEmail != null) map['user_email'] = userEmail;
    if (userPhone != null) map['user_phone'] = userPhone;
    if (userBirth != null) map['user_birth'] = userBirth;
    if (startWork != null) map['start_work'] = startWork;
    if (endWork != null) map['end_work'] = endWork;
    if (roleName != null) map['role_name'] = roleName;
    if (officeName != null) map['office_name'] = officeName;
    if (userPassword != null) map['user_password'] = userPassword;
    return map;
  }
}

