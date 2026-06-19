/// File: lib/features/notification/presentation/controllers/notification_controller.dart
/// Generated Documentation for notification_controller.dart

import 'package:flutter/material.dart';

import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';

/// Class representing `NotificationController`.
/// Auto-generated class documentation.
class NotificationController extends ChangeNotifier {
  final GetNotificationsUseCase _getNotifications;

  NotificationController({
    required GetNotificationsUseCase getNotifications,
  }) : _getNotifications = getNotifications;

  bool _loading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _loading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  List<AppNotification> _notifications = [];
  /// Getter for `notifications` returning `List<AppNotification>`.
  List<AppNotification> get notifications => _notifications;

  /// Method `init` returning `Future<void>`.
  /// Handles logic operations related to `init`.
  Future<void> init() => fetchNotifications();

  /// Method `fetchNotifications` returning `Future<void>`.
  /// Handles logic operations related to `fetchNotifications`.
  Future<void> fetchNotifications() async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _getNotifications();

    if (res.isSuccess) {
      _notifications = res.data ?? [];
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memuat notifikasi';
    }

    _setLoading(false);
  }

  /// Method `_setLoading` returning `void`.
  /// Handles logic operations related to `_setLoading`.
  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
