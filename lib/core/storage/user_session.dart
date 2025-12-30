import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/domain/entities/auth_session.dart';

class UserSession {
  static const _kSessionKey = 'user_session';
  final FlutterSecureStorage _storage;

  UserSession(this._storage);

  Future<void> saveSession(AuthSession s) async {
    final jsonStr = jsonEncode({
      'user_id': s.userId,
      'user_name': s.userName,
      'user_email': s.userEmail,
      'role_id': s.roleId,
      'role_name': s.roleName,
      'office_id': s.officeId,
      'office_name': s.officeName,
    });

    await _storage.write(key: _kSessionKey, value: jsonStr);
  }

  Future<Map<String, dynamic>?> readSession() async {
    final raw = await _storage.read(key: _kSessionKey);
    if (raw == null || raw.isEmpty) return null;
    return jsonDecode(raw) as Map<String, dynamic>;
  }

  Future<void> clear() => _storage.delete(key: _kSessionKey);
}
