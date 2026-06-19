/// File: lib/core/di/service_locator.dart
/// Generated Documentation for service_locator.dart

import 'package:get_it/get_it.dart';

import 'core_di.dart';
import 'auth_di.dart';
import 'home_di.dart';
import 'visit_di.dart';
import 'attendance_di.dart';
import 'profile_di.dart';
import 'leave_di.dart';
import 'overtime_di.dart';
import 'notification_di.dart';
import 'crew_di.dart';
import 'out_of_office_di.dart';

final GetIt sl = GetIt.instance;

/// Method `setupLocator` returning `Future<void>`.
/// Handles logic operations related to `setupLocator`.
Future<void> setupLocator() async {
  registerCoreDi(sl);
  registerAuthDi(sl);
  registerHomeDi(sl);
  registerVisitDi(sl);
  registerAttendanceDi(sl);
  registerProfileDi(sl);
  registerLeaveDi(sl);
  registerOvertimeDi(sl);
  registerNotificationDi(sl);
  registerCrewDi(sl);
  registerOutOfOfficeDi(sl);
}

/// Method `resetLocator` returning `Future<void>`.
/// Handles logic operations related to `resetLocator`.
Future<void> resetLocator() async {
  await sl.reset();
}
