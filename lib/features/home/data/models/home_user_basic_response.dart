/// File: lib/features/home/data/models/home_user_basic_response.dart
/// Generated Documentation for home_user_basic_response.dart

/// Class representing `HomeUserBasicResponse`.
/// Auto-generated class documentation.
class HomeUserBasicResponse {
  final int userId;
  final String userName;
  final String roleName;
  final String? userPhoto;

  HomeUserBasicResponse({
    required this.userId,
    required this.userName,
    required this.roleName,
    this.userPhoto,
  });

  factory HomeUserBasicResponse.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = (json['userBasic'] is Map<String, dynamic>)
        ? json['userBasic'] as Map<String, dynamic>
        : ((json['data'] is Map<String, dynamic>)
            ? json['data'] as Map<String, dynamic>
            : json);

    return HomeUserBasicResponse(
      userId: (data['user_id'] as num?)?.toInt() ?? 0,
      userName: (data['user_name'] as String?) ?? '',
      roleName: (data['role_name'] as String?) ?? '',
      userPhoto: data['user_photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'user_name': userName,
      'role_name': roleName,
      'user_photo': userPhoto,
    };
  }
}
