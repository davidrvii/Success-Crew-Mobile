/// File: lib/core/storage/user_session.dart
/// Generated Documentation for user_session.dart

import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../features/auth/domain/entities/auth_session.dart';

/// Class representing `UserSession`.
/// Auto-generated class documentation.
class UserSession {
  static const _kSessionKey = 'user_session';
  static const _kTodayAttendanceId = 'today_attendance_id';

  final FlutterSecureStorage _storage;
  UserSession(this._storage);

  /// Method `saveSession` returning `Future<void>`.
  /// Handles logic operations related to `saveSession`.
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

  /// Method `readUserId` returning `Future<int?>`.
  /// Handles logic operations related to `readUserId`.
  Future<int?> readUserId() async {
    final s = await readSession();
    final id = s?['user_id'];
    return id?.toInt();
  }

  /// Method `readUserName` returning `Future<String?>`.
  /// Handles logic operations related to `readUserName`.
  Future<String?> readUserName() async {
    final s = await readSession();
    return (s?['user_name'])?.toString();
  }

  /// Method `clear` returning `Future<void>`.
  /// Handles logic operations related to `clear`.
  Future<void> clear() async {
    await _storage.delete(key: _kSessionKey);
    await _storage.delete(key: _kTodayAttendanceId);
  }

  /// Method `readTodayAttendanceId` returning `Future<int?>`.
  /// Handles logic operations related to `readTodayAttendanceId`.
  Future<int?> readTodayAttendanceId() async {
    final raw = await _storage.read(key: _kTodayAttendanceId);
    if (raw == null) return null;
    return int.tryParse(raw);
  }

  /// Method `saveTodayAttendanceId` returning `Future<void>`.
  /// Handles logic operations related to `saveTodayAttendanceId`.
  Future<void> saveTodayAttendanceId(int id) async {
    await _storage.write(key: _kTodayAttendanceId, value: id.toString());
  }

  /// Method `clearTodayAttendanceId` returning `Future<void>`.
  /// Handles logic operations related to `clearTodayAttendanceId`.
  Future<void> clearTodayAttendanceId() =>
      _storage.delete(key: _kTodayAttendanceId);
}
