/// File: lib/features/profile/data/models/user_detail_model.dart
/// Generated Documentation for user_detail_model.dart

/// Class representing `UserDetailDto`.
/// Auto-generated class documentation.
class UserDetailDto {
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

  // New fields
  final String? crewStatus;
  final String? contractStatus;
  final String? userPhone;
  final DateTime? userBirth;
  final DateTime? startWork;
  final DateTime? endWork;

  final int? totalAttendance;
  final int? totalLate;
  final int? totalLeave;
  final int? totalOvertime;
  final int? totalOutOfOffice;

  final List<CrewHistoryDto>? history;

  const UserDetailDto({
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
    this.totalAttendance,
    this.totalLate,
    this.totalLeave,
    this.totalOvertime,
    this.totalOutOfOffice,
    this.history,
  });

  factory UserDetailDto.fromJson(Map<String, dynamic> json) {
    return UserDetailDto(
      userId: (json['user_id'] as num?)?.toInt() ?? 0,
      officeId: (json['office_id'] as num?)?.toInt(),
      roleId: (json['role_id'] as num?)?.toInt(),
      userName: (json['user_name'] as String?) ?? '',
      userEmail: (json['user_email'] as String?) ?? '',
      userPhoto: json['user_photo']?.toString(),
      roleName: json['role_name'] as String?,
      officeName: json['office_name'] as String?,
      createdAt: _tryParseDate(json['created_at']),
      updatedAt: _tryParseDate(json['updated_at']),
      crewStatus: json['crew_status'] as String?,
      contractStatus: json['contract_status'] as String?,
      userPhone: json['user_phone'] as String?,
      userBirth: _tryParseDate(json['user_birth']),
      startWork: _tryParseDate(json['start_work']),
      endWork: _tryParseDate(json['end_work']),
      totalAttendance: (json['total_attendance'] as num?)?.toInt(),
      totalLate: (json['total_late'] as num?)?.toInt(),
      totalLeave: (json['total_leave'] as num?)?.toInt(),
      totalOvertime: (json['total_overtime'] as num?)?.toInt(),
      totalOutOfOffice: (json['total_out_of_office'] as num?)?.toInt(),
      history: (json['history'] as List?)
          ?.whereType<Map<String, dynamic>>()
          .map(CrewHistoryDto.fromJson)
          .toList(),
    );
  }

  static DateTime? _tryParseDate(dynamic v) {
    if (v is String) return DateTime.tryParse(v);
    return null;
  }
}

/// Class representing `CrewHistoryDto`.
/// Auto-generated class documentation.
class CrewHistoryDto {
  final int id;
  final String type;
  final DateTime? date;
  final String? status;
  final String? description;
  final Map<String, dynamic>? details;

  const CrewHistoryDto({
    required this.id,
    required this.type,
    this.date,
    this.status,
    this.description,
    this.details,
  });

  factory CrewHistoryDto.fromJson(Map<String, dynamic> json) {
    return CrewHistoryDto(
      id: (json['id'] as num?)?.toInt() ?? 0,
      type: (json['type'] as String?) ?? '',
      date: _tryParseDate(json['date']),
      status: json['status'] as String?,
      description: json['description'] as String?,
      details: json['details'] as Map<String, dynamic>?,
    );
  }

  static DateTime? _tryParseDate(dynamic v) {
    if (v is String) return DateTime.tryParse(v);
    return null;
  }
}

/// Class representing `UserDetailResponse`.
/// Auto-generated class documentation.
class UserDetailResponse {
  final int statusCode;
  final String message;
  final UserDetailDto? userDetail;

  const UserDetailResponse({
    required this.statusCode,
    required this.message,
    required this.userDetail,
  });

  factory UserDetailResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['userDetail'] ?? json['user'] ?? json['userCrew'];
    return UserDetailResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      userDetail: payload is Map<String, dynamic>
          ? UserDetailDto.fromJson(payload)
          : null,
    );
  }
}
