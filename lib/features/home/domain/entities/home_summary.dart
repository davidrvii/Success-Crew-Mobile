import 'home_attendance_summary.dart';
import 'home_request_summary.dart';
import 'home_user_basic.dart';
import 'home_visit_summary.dart';

class HomeSummary {
  final HomeUserBasic user;
  final int unreadNotificationCount;

  final HomeAttendanceSummary attendance;
  final HomeRequestSummary requests;
  final HomeVisitSummary visitors;

  const HomeSummary({
    required this.user,
    required this.unreadNotificationCount,
    required this.attendance,
    required this.requests,
    required this.visitors,
  });
}
