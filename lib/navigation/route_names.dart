class RouteNames {
  RouteNames._();

  // ===== App entry / base =====
  static const String root = '/';
  static const String main = '/main';

  // ===== Auth (USER) =====
  static const String login = '/login';
  static const String register = '/register';

  // ===== Profile (USER) =====
  static const String profile = '/profile';
  static const String profileEdit = '/profile/edit';

  // ===== Notification =====
  static const String notifications = '/notifications';
  static const String notificationDetail = '/notifications/detail';

  // ===== Attendance =====
  static const String attendance = '/attendance';
  static const String attendanceDetail = '/attendance/detail';
  static const String attendanceCheckIn = '/attendance/check-in';
  static const String attendanceCheckOut = '/attendance/check-out';

  // ===== Leave =====
  static const String leave = '/leave';
  static const String leaveCreate = '/leave/create';
  static const String leaveDetail = '/leave/detail';

  // ===== Overtime =====
  static const String overtime = '/overtime';
  static const String overtimeCreate = '/overtime/create';
  static const String overtimeDetail = '/overtime/detail';

  // ===== Visitor / Tracker (Visit) =====
  static const String visit = '/visit';
  static const String visitCreate = '/visit/create';
  static const String visitDetail = '/visit/detail';
  static const String visitFollowUps = '/visit/follow-up';
  static const String visitProductsSold = '/visit/products-sold';
  static const String visitUnitsServiced = '/visit/units-serviced';
}

class IdArgs {
  final String id;
  const IdArgs(this.id);
}

class TwoIdArgs {
  final String id1;
  final String id2;
  const TwoIdArgs(this.id1, this.id2);
}
