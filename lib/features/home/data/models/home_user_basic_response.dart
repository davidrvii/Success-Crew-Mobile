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
    return HomeUserBasicResponse(
      userId: json['user_id'] as int,
      userName: json['user_name'] as String,
      roleName: json['role_name'] as String,
      userPhoto: json['user_photo'] as String?,
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
