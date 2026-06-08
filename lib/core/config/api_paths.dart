class ApiPaths {
  ApiPaths._();

  static const String root = '/';

  // USER (/user)
  static const String userAdmin = '/user/admin';
  static const String userRegister = '/user/register';
  static const String userLogin = '/user/login';

  static String userDetail(int id) => '/user/detail/$id';
  static String userBasic(int id) => '/user/basic/$id';
  static String userUpdate(int id) => '/user/update/$id';
  static String userDelete(int id) => '/user/delete/$id';

  // NOTIFICATION (/notification)
  static const String notificationAdmin = '/notification/admin';
  static const String notificationAdd = '/notification/add';

  static String notificationHistory(int userId) =>
      '/notification/history/$userId';
  static String notificationDetail(int id) => '/notification/detail/$id';
  static String notificationUpdate(int id) => '/notification/update/$id';
  static String notificationDelete(int id) => '/notification/delete/$id';

  // ATTENDANCE (/attendance)
  static const String attendanceAdmin = '/attendance/admin';
  static const String attendanceCheckIn = '/attendance/check-in';

  static String attendanceCrew(int userId) => '/attendance/crew/$userId';
  static String attendanceDetail(int id) => '/attendance/detail/$id';
  static String attendanceCheckOut(int id) => '/attendance/check-out/$id';
  static String attendanceDelete(int id) => '/attendance/delete/$id';

  // LEAVE (/leave)
  static const String leaveAdmin = '/leave/admin';
  static const String leaveAdd = '/leave/add';

  static String leaveCrew(int userId) => '/leave/crew/$userId';
  static String leaveDetail(int id) => '/leave/detail/$id';
  static String leaveUpdate(int id) => '/leave/update/$id';
  static String leaveDelete(int id) => '/leave/delete/$id';

  // OVERTIME (/overtime)
  static const String overtimeAdmin = '/overtime/admin';
  static const String overtimeAdd = '/overtime/add';

  static String overtimeCrew(int userId) => '/overtime/crew/$userId';
  static String overtimeDetail(int id) => '/overtime/detail/$id';
  static String overtimeUpdate(int id) => '/overtime/update/$id';
  static String overtimeDelete(int id) => '/overtime/delete/$id';

  // VISIT / TRACKER (/visit)
  static const String visitAdmin = '/visit/admin';
  static const String visitAdd = '/visit/add';

  static String visitDetail(int id) => '/visit/detail/$id';
  static String visitUpdate(int id) => '/visit/update/$id';
  static String visitDelete(int id) => '/visit/delete/$id';

  // Follow-up
  static String visitFollowUps(int visitId) => '/visit/$visitId/follow-up';
  static String visitFollowUpById(int visitId, int followUpId) =>
      '/visit/$visitId/follow-up/$followUpId';

  // Products sold
  static String visitProductsSold(int visitId) =>
      '/visit/$visitId/products-sold';
  static String visitProductSoldById(int visitId, int productSoldId) =>
      '/visit/$visitId/products-sold/$productSoldId';

  // Units serviced
  static String visitUnitsServiced(int visitId) =>
      '/visit/$visitId/units-serviced';
  static String visitUnitServicedById(int visitId, int unitServicedId) =>
      '/visit/$visitId/units-serviced/$unitServicedId';
}
