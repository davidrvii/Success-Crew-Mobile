import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/di/service_locator.dart';
import '../core/storage/token_storage.dart';
import '../core/storage/user_session.dart';

// AUTH
import '../features/auth/presentation/controllers/login_controller.dart';
import '../features/auth/presentation/controllers/register_controller.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';

// HOME
import '../features/home/presentation/controllers/home_controller.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/visitor_tracker/presentation/pages/visit_detail_page.dart';
import '../features/visitor_tracker/presentation/pages/visit_page.dart';
import '../features/visitor_tracker/presentation/pages/visit_form_page.dart';
import '../features/visitor_tracker/presentation/controllers/visit_controller.dart';

// ATTENDANCE
import '../features/attendance/presentation/pages/attendance_page.dart';
import '../features/attendance/presentation/controllers/attendance_controller.dart';

// PROFILE
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/profile/presentation/pages/edit_profile_page.dart';
import '../features/profile/presentation/controllers/profile_controller.dart';

// LEAVE
import '../features/leave/presentation/pages/leave_list_page.dart';
import '../features/leave/presentation/pages/leave_form_page.dart';
import '../features/leave/presentation/controllers/leave_controller.dart';

// OVERTIME
import '../features/overtime/presentation/pages/overtime_list_page.dart';
import '../features/overtime/presentation/pages/overtime_form_page.dart';
import '../features/overtime/presentation/controllers/overtime_controller.dart';

// NOTIFICATION
import '../features/notification/presentation/pages/notification_page.dart';
import '../features/notification/presentation/controllers/notification_controller.dart';

// CREW
import '../features/crew/presentation/pages/crew_page.dart';
import '../features/crew/presentation/controllers/crew_controller.dart';

import 'main_shell.dart';

class AppGoRouter {
  AppGoRouter._();

  // Auth routes
  static const String login = '/login';
  static const String register = '/register';

  // Shell root routes
  static const String home = '/home';
  static const String visitor = '/visitor';
  static const String absence = '/absence';
  static const String crew = '/crew';

  // Sub routes
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String leave = '/leave';
  static const String leaveAdd = '/leave-add';
  static const String overtime = '/overtime';
  static const String overtimeAdd = '/overtime-add';
  static const String notification = '/notification';
  static const String visitorAdd = '/visitor-add';

  static final GoRouter router = GoRouter(
    initialLocation: login,
    debugLogDiagnostics: true,
    redirect: _authRedirect,
    routes: <RouteBase>[
      // AUTH
      GoRoute(
        path: login,
        builder: (context, state) {
          return LoginPage(
            controller: sl<LoginController>(),
            disposeController: true,
            onLoginSuccess: () => context.go(home),
          );
        },
      ),
      GoRoute(
        path: register,
        builder: (context, state) {
          return RegisterPage(
            controller: sl<RegisterController>(),
            disposeController: true,
            onRegisterSuccess: () => context.go(login),
          );
        },
      ),
      GoRoute(
        path: '/visit-detail',
        builder: (context, state) {
          final visitId = state.extra as int;
          return VisitDetailPage(visitId: visitId);
        },
      ),
      GoRoute(
        path: visitorAdd,
        builder: (context, state) {
          return VisitFormPage(
            controller: sl<VisitorController>(),
          );
        },
      ),
      GoRoute(
        path: profile,
        builder: (context, state) {
          return ProfilePage(
            controller: sl<ProfileController>(),
          );
        },
      ),
      GoRoute(
        path: editProfile,
        builder: (context, state) {
          return EditProfilePage(
            controller: sl<ProfileController>(),
          );
        },
      ),
      GoRoute(
        path: leave,
        builder: (context, state) {
          return LeaveListPage(
            controller: sl<LeaveController>(),
          );
        },
      ),
      GoRoute(
        path: leaveAdd,
        builder: (context, state) {
          return LeaveFormPage(
            controller: sl<LeaveController>(),
          );
        },
      ),
      GoRoute(
        path: overtime,
        builder: (context, state) {
          return OvertimeListPage(
            controller: sl<OvertimeController>(),
          );
        },
      ),
      GoRoute(
        path: overtimeAdd,
        builder: (context, state) {
          return OvertimeFormPage(
            controller: sl<OvertimeController>(),
          );
        },
      ),
      GoRoute(
        path: notification,
        builder: (context, state) {
          return NotificationPage(
            controller: sl<NotificationController>(),
          );
        },
      ),

      // MAIN SHELL (BottomNav)
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          // -------- HOME --------
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: home,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: HomePage(
                      controller: sl<HomeController>(),
                      disposeController: true,
                      onTapProfile: () => context.push(profile),
                      onTapNotifications: () => context.push(notification),
                      onTapLeave: () => context.push(leave),
                      onTapOvertime: () => context.push(overtime),
                      onTapCheckIn: () => context.go(absence),
                    ),
                  );
                },
              ),
            ],
          ),

          // -------- VISITOR --------
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: visitor,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: VisitorPage(),
                ),
              ),
            ],
          ),

          // -------- ABSENCE --------
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: absence,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: AttendancePage(
                    controller: sl<AttendanceController>(),
                  ),
                ),
              ),
            ],
          ),

          // -------- CREW --------
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: crew,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: CrewPage(
                    controller: sl<CrewController>(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => RouterErrorPage(error: state.error),
  );

  // AUTH GUARD
  static Future<String?> _authRedirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final tokenStorage = sl<TokenStorage>();
    final session = sl<UserSession>();

    final accessToken = await tokenStorage.getAccessToken();
    final hasSession = (await session.readSession()) != null;

    final isLoggedIn =
        (accessToken != null && accessToken.isNotEmpty) || hasSession;

    final location = state.uri.toString();
    final isAuthRoute = location == login || location == register;

    if (!isLoggedIn) {
      return isAuthRoute ? null : login;
    }

    if (isAuthRoute) return home;

    return null;
  }
}

// PLACEHOLDER PAGE
class PlaceholderScaffold extends StatelessWidget {
  final String title;
  const PlaceholderScaffold({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('$title Page (placeholder)', textAlign: TextAlign.center),
      ),
    );
  }
}

// ROUTER ERROR PAGE
class RouterErrorPage extends StatelessWidget {
  final Object? error;
  const RouterErrorPage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Routing Error')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Terjadi error routing.\n\n$error',
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
