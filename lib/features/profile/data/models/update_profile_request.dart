import 'dart:io';
import 'package:dio/dio.dart';

class UpdateProfileRequest {
  final int? officeId;
  final int? roleId;

  final String? userName;
  final String? userEmail;
  final String? userPassword;

  final File? photoFile;

  const UpdateProfileRequest({
    this.officeId,
    this.roleId,
    this.userName,
    this.userEmail,
    this.userPassword,
    this.photoFile,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    if (officeId != null) map['office_id'] = officeId;
    if (roleId != null) map['role_id'] = roleId;

    if (userName != null && userName!.isNotEmpty) map['user_name'] = userName;
    if (userEmail != null && userEmail!.isNotEmpty) {
      map['user_email'] = userEmail;
    }
    if (userPassword != null && userPassword!.isNotEmpty) {
      map['user_password'] = userPassword;
    }

    return map;
  }

  Future<FormData> toFormData() async {
    final map = toJson();

    if (photoFile != null) {
      final fileName = photoFile!.path.split(Platform.pathSeparator).last;
      map['user_photo'] = await MultipartFile.fromFile(
        photoFile!.path,
        filename: fileName,
      );
    }

    return FormData.fromMap(map);
  }
}
