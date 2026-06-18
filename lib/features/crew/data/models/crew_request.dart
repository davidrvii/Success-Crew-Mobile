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
  final String? roleDivision;
  final String? officeName;

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
    this.roleDivision,
    this.officeName,
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
    if (roleDivision != null) map['role_division'] = roleDivision;
    if (officeName != null) map['office_name'] = officeName;
    return map;
  }
}
