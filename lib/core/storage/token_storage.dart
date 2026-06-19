/// File: lib/core/storage/token_storage.dart
/// Generated Documentation for token_storage.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class TokenStorage {
  /// Method `saveAccessToken` returning `Future<void>`.
  /// Handles logic operations related to `saveAccessToken`.
  Future<void> saveAccessToken(String token);
  /// Method `getAccessToken` returning `Future<String?>`.
  /// Handles logic operations related to `getAccessToken`.
  Future<String?> getAccessToken();

  /// Method `saveRefreshToken` returning `Future<void>`.
  /// Handles logic operations related to `saveRefreshToken`.
  Future<void> saveRefreshToken(String token);
  /// Method `getRefreshToken` returning `Future<String?>`.
  /// Handles logic operations related to `getRefreshToken`.
  Future<String?> getRefreshToken();

  /// Method `clear` returning `Future<void>`.
  /// Handles logic operations related to `clear`.
  Future<void> clear();
}

/// Class representing `TokenStorageImpl`.
/// Auto-generated class documentation.
class TokenStorageImpl implements TokenStorage {
  static const _kAccessToken = 'access_token';
  static const _kRefreshToken = 'refresh_token';

  final FlutterSecureStorage _storage;

  TokenStorageImpl(this._storage);

  @override
  /// Method `saveAccessToken` returning `Future<void>`.
  /// Handles logic operations related to `saveAccessToken`.
  Future<void> saveAccessToken(String token) {
    return _storage.write(key: _kAccessToken, value: token);
  }

  @override
  /// Method `getAccessToken` returning `Future<String?>`.
  /// Handles logic operations related to `getAccessToken`.
  Future<String?> getAccessToken() {
    return _storage.read(key: _kAccessToken);
  }

  @override
  /// Method `saveRefreshToken` returning `Future<void>`.
  /// Handles logic operations related to `saveRefreshToken`.
  Future<void> saveRefreshToken(String token) {
    return _storage.write(key: _kRefreshToken, value: token);
  }

  @override
  /// Method `getRefreshToken` returning `Future<String?>`.
  /// Handles logic operations related to `getRefreshToken`.
  Future<String?> getRefreshToken() {
    return _storage.read(key: _kRefreshToken);
  }

  @override
  /// Method `clear` returning `Future<void>`.
  /// Handles logic operations related to `clear`.
  Future<void> clear() async {
    await _storage.delete(key: _kAccessToken);
    await _storage.delete(key: _kRefreshToken);
  }
}
