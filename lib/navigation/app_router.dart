import 'package:flutter/material.dart';

import 'route_names.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ===== Entry / Main =====
      case RouteNames.root:
        return _page(settings, const _PlaceholderPage(title: 'Root'));

      case RouteNames.main:
        return _page(settings, const _PlaceholderPage(title: 'Main'));

      // ===== Auth =====
      case RouteNames.login:
        return _page(settings, const _PlaceholderPage(title: 'Login Page'));

      case RouteNames.register:
        return _page(settings, const _PlaceholderPage(title: 'Register Page'));

      // ===== Profile =====
      case RouteNames.profile:
        return _page(settings, const _PlaceholderPage(title: 'Profile Page'));

      case RouteNames.profileEdit:
        return _page(
          settings,
          const _PlaceholderPage(title: 'Edit Profile Page'),
        );

      // ===== Notification =====
      case RouteNames.notifications:
        return _page(
          settings,
          const _PlaceholderPage(title: 'Notifications Page'),
        );

      case RouteNames.notificationDetail:
        {
          final id = _requireId(settings.arguments);
          if (id == null) {
            return _badArgs(settings, 'notification id is required');
          }
          return _page(
            settings,
            _PlaceholderPage(title: 'Notification Detail (id: $id)'),
          );
        }

      // ===== Attendance =====
      case RouteNames.attendance:
        return _page(
          settings,
          const _PlaceholderPage(title: 'Attendance Page'),
        );

      case RouteNames.attendanceCheckIn:
        return _page(
          settings,
          const _PlaceholderPage(title: 'Attendance Check-in'),
        );

      case RouteNames.attendanceCheckOut:
        {
          final id = _requireId(settings.arguments);
          if (id == null) {
            return _badArgs(
              settings,
              'attendance id is required for check-out',
            );
          }
          return _page(
            settings,
            _PlaceholderPage(title: 'Attendance Check-out (id: $id)'),
          );
        }

      case RouteNames.attendanceDetail:
        {
          final id = _requireId(settings.arguments);
          if (id == null) {
            return _badArgs(settings, 'attendance id is required');
          }
          return _page(
            settings,
            _PlaceholderPage(title: 'Attendance Detail (id: $id)'),
          );
        }

      // ===== Leave =====
      case RouteNames.leave:
        return _page(settings, const _PlaceholderPage(title: 'Leave Page'));

      case RouteNames.leaveCreate:
        return _page(settings, const _PlaceholderPage(title: 'Leave Create'));

      case RouteNames.leaveDetail:
        {
          final id = _requireId(settings.arguments);
          if (id == null) return _badArgs(settings, 'leave id is required');
          return _page(
            settings,
            _PlaceholderPage(title: 'Leave Detail (id: $id)'),
          );
        }

      // ===== Overtime =====
      case RouteNames.overtime:
        return _page(settings, const _PlaceholderPage(title: 'Overtime Page'));

      case RouteNames.overtimeCreate:
        return _page(
          settings,
          const _PlaceholderPage(title: 'Overtime Create'),
        );

      case RouteNames.overtimeDetail:
        {
          final id = _requireId(settings.arguments);
          if (id == null) return _badArgs(settings, 'overtime id is required');
          return _page(
            settings,
            _PlaceholderPage(title: 'Overtime Detail (id: $id)'),
          );
        }

      // ===== Visit / Tracker =====
      case RouteNames.visit:
        return _page(
          settings,
          const _PlaceholderPage(title: 'Visit/Tracker Page'),
        );

      case RouteNames.visitCreate:
        return _page(settings, const _PlaceholderPage(title: 'Visit Create'));

      case RouteNames.visitDetail:
        {
          final id = _requireId(settings.arguments);
          if (id == null) return _badArgs(settings, 'visit id is required');
          return _page(
            settings,
            _PlaceholderPage(title: 'Visit Detail (id: $id)'),
          );
        }

      case RouteNames.visitFollowUps:
        {
          final id = _requireId(settings.arguments);
          if (id == null) {
            return _badArgs(settings, 'visitId is required for follow-ups');
          }
          return _page(
            settings,
            _PlaceholderPage(title: 'Visit Follow-ups (visitId: $id)'),
          );
        }

      case RouteNames.visitProductsSold:
        {
          final id = _requireId(settings.arguments);
          if (id == null) {
            return _badArgs(settings, 'visitId is required for products sold');
          }
          return _page(
            settings,
            _PlaceholderPage(title: 'Products Sold (visitId: $id)'),
          );
        }

      case RouteNames.visitUnitsServiced:
        {
          final id = _requireId(settings.arguments);
          if (id == null) {
            return _badArgs(settings, 'visitId is required for units serviced');
          }
          return _page(
            settings,
            _PlaceholderPage(title: 'Units Serviced (visitId: $id)'),
          );
        }

      default:
        return _unknown(settings);
    }
  }

  // ---------- Helpers ----------

  static MaterialPageRoute _page(RouteSettings settings, Widget child) {
    return MaterialPageRoute(settings: settings, builder: (_) => child);
  }

  /// Getting args in commonly used format :
  /// - IdArgs('123')
  /// - {'id': '123'}
  /// - '123'
  static String? _requireId(Object? args) {
    if (args == null) return null;

    if (args is IdArgs) return args.id;

    if (args is String && args.trim().isNotEmpty) return args;

    if (args is Map) {
      final val = args['id'];
      if (val is String && val.trim().isNotEmpty) return val;
    }

    return null;
  }

  static Route<dynamic> _badArgs(RouteSettings settings, String message) {
    return _page(
      settings,
      _ErrorPage(
        title: 'Bad arguments',
        message: message,
        routeName: settings.name,
        args: settings.arguments,
      ),
    );
  }

  static Route<dynamic> _unknown(RouteSettings settings) {
    return _page(
      settings,
      _ErrorPage(
        title: 'Unknown route',
        message: 'Route is not registered.',
        routeName: settings.name,
        args: settings.arguments,
      ),
    );
  }
}

// ---------- Simple placeholder & error pages ----------

class _PlaceholderPage extends StatelessWidget {
  final String title;
  const _PlaceholderPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title, textAlign: TextAlign.center)),
    );
  }
}

class _ErrorPage extends StatelessWidget {
  final String title;
  final String message;
  final String? routeName;
  final Object? args;

  const _ErrorPage({
    required this.title,
    required this.message,
    this.routeName,
    this.args,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Message: $message\nRoute: ${routeName ?? "-"}\nArgs: ${args ?? "-"}',
        ),
      ),
    );
  }
}
