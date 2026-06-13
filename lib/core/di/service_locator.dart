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

final GetIt sl = GetIt.instance;

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
}

Future<void> resetLocator() async {
  await sl.reset();
}
