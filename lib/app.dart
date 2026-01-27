import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'navigation/go_router_config.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: const [
        // Provider akan kita isi bertahap (HomeController, dsb)
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Attendance App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        routerConfig: AppGoRouter.router,
      ),
    );
  }
}
