import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'navigation/go_router_config.dart';

import 'features/auth/presentation/controllers/login_controller.dart';
import 'features/auth/presentation/controllers/register_controller.dart';
import 'features/home/presentation/controllers/home_controller.dart';
import 'features/attendance/presentation/controllers/attendance_controller.dart';
import 'features/profile/presentation/controllers/profile_controller.dart';
import 'features/leave/presentation/controllers/leave_controller.dart';
import 'features/overtime/presentation/controllers/overtime_controller.dart';
import 'features/notification/presentation/controllers/notification_controller.dart';
import 'features/visitor_tracker/presentation/controllers/visit_controller.dart';
import 'features/visitor_tracker/presentation/controllers/visit_detail_controller.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<LoginController>()),
        ChangeNotifierProvider(create: (_) => sl<RegisterController>()),
        ChangeNotifierProvider(create: (_) => sl<HomeController>()),
        ChangeNotifierProvider(create: (_) => sl<AttendanceController>()),
        ChangeNotifierProvider(create: (_) => sl<ProfileController>()),
        ChangeNotifierProvider(create: (_) => sl<LeaveController>()),
        ChangeNotifierProvider(create: (_) => sl<OvertimeController>()),
        ChangeNotifierProvider(create: (_) => sl<NotificationController>()),
        ChangeNotifierProvider(create: (_) => sl<VisitorController>()),
        ChangeNotifierProvider(create: (_) => sl<VisitDetailController>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Attendance App',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light, // Di-force ke light mode karena background screen di-hardcode putih/terang
        routerConfig: AppGoRouter.router,
      ),
    );
  }
}

