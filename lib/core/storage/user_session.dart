import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSession {
  static const _kUserId = 'user_id';
  static const _kRole = 'user_role';

  final FlutterSecureStorage _storage;

  UserSession(this._storage);

  Future<void> setUserId(String userId) =>
      _storage.write(key: _kUserId, value: userId);

  Future<String?> getUserId() => _storage.read(key: _kUserId);

  Future<void> setRole(String role) => _storage.write(key: _kRole, value: role);

  Future<String?> getRole() => _storage.read(key: _kRole);

  Future<bool> isLoggedIn() async {
    final userId = await getUserId();
    return userId != null && userId.isNotEmpty;
  }

  Future<void> clear() async {
    await _storage.delete(key: _kUserId);
    await _storage.delete(key: _kRole);
  }
}
