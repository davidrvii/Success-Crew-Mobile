import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage {
  Future<void> saveAccessToken(String token);
  Future<String?> getAccessToken();

  Future<void> saveRefreshToken(String token);
  Future<String?> getRefreshToken();

  Future<void> clear();
}

class TokenStorageImpl implements TokenStorage {
  static const _kAccessToken = 'access_token';
  static const _kRefreshToken = 'refresh_token';

  final FlutterSecureStorage _storage;

  TokenStorageImpl(this._storage);

  @override
  Future<void> saveAccessToken(String token) {
    return _storage.write(key: _kAccessToken, value: token);
  }

  @override
  Future<String?> getAccessToken() {
    return _storage.read(key: _kAccessToken);
  }

  @override
  Future<void> saveRefreshToken(String token) {
    return _storage.write(key: _kRefreshToken, value: token);
  }

  @override
  Future<String?> getRefreshToken() {
    return _storage.read(key: _kRefreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _kAccessToken);
    await _storage.delete(key: _kRefreshToken);
  }
}
