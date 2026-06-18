import '../../../profile/data/models/user_detail_model.dart';

class CrewMutationResponse {
  final int statusCode;
  final String message;
  final UserDetailDto? user;

  const CrewMutationResponse({
    required this.statusCode,
    required this.message,
    required this.user,
  });

  factory CrewMutationResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['crewAdded'] ?? json['crewUpdated'] ?? json['user'];
    return CrewMutationResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      user: payload is Map<String, dynamic>
          ? UserDetailDto.fromJson(payload)
          : null,
    );
  }
}

class UserDeleteResponse {
  final int statusCode;
  final String message;
  final int userId;

  const UserDeleteResponse({
    required this.statusCode,
    required this.message,
    required this.userId,
  });

  factory UserDeleteResponse.fromJson(Map<String, dynamic> json) {
    return UserDeleteResponse(
      statusCode: (json['statusCode'] as num?)?.toInt() ?? 0,
      message: (json['message'] as String?) ?? '',
      userId: (json['userId'] as num?)?.toInt() ?? 0,
    );
  }
}
