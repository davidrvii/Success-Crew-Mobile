import 'package:flutter/material.dart';

import '../../domain/entities/notification.dart';
import '../../domain/usecases/get_notifications.dart';

class NotificationController extends ChangeNotifier {
  final GetNotificationsUseCase _getNotifications;

  NotificationController({
    required GetNotificationsUseCase getNotifications,
  }) : _getNotifications = getNotifications;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;

  Future<void> init() => fetchNotifications();

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

  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
