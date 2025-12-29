import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Attendance App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,

        initialRoute: AppRoutes.login,
        routes: {
          AppRoutes.login: (_) => const Placeholder(),
          AppRoutes.register: (_) => const Placeholder(),
          AppRoutes.shell: (_) => const Placeholder(),
        },

        onUnknownRoute: (settings) => MaterialPageRoute(
          builder: (_) => UnknownRoutePage(routeName: settings.name),
        ),
      ),
    );
  }
}

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';
  static const String register = '/register';
  static const String shell = '/shell';
}

class UnknownRoutePage extends StatelessWidget {
  final String? routeName;
  const UnknownRoutePage({super.key, this.routeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Route tidak ditemukan')),
      body: Center(
        child: Text(
          'Route tidak dikenal: ${routeName ?? "-"}',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
