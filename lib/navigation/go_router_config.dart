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
                    ),
                  );
                },
              ),
            ],
          ),

          // -------- VISITOR (placeholder) --------
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: visitor,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PlaceholderScaffold(title: 'Visitor'),
                ),
              ),
            ],
          ),

          // -------- ABSENCE (placeholder) --------
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: absence,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PlaceholderScaffold(title: 'Absence'),
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
