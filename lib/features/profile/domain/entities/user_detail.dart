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

  // Personal info
  final String? crewStatus;
  final String? contractStatus;
  final String? userPhone;
  final DateTime? userBirth;
  final DateTime? startWork;
  final DateTime? endWork;
  final String? roleDivision;

  // Statistics
  final int? totalAttendance;
  final int? totalLate;
  final int? totalLeave;
  final int? totalOvertime;
  final int? totalOutOfOffice;

  // History logs
  final List<CrewHistory>? history;

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
    this.crewStatus,
    this.contractStatus,
    this.userPhone,
    this.userBirth,
    this.startWork,
    this.endWork,
    this.roleDivision,
    this.totalAttendance,
    this.totalLate,
    this.totalLeave,
    this.totalOvertime,
    this.totalOutOfOffice,
    this.history,
  });
}

class CrewHistory {
  final int id;
  final String type;
  final DateTime? date;
  final String? status;
  final String? description;
  final Map<String, dynamic>? details;

  const CrewHistory({
    required this.id,
    required this.type,
    this.date,
    this.status,
    this.description,
    this.details,
  });
}
