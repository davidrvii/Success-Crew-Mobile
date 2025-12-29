class ApiPaths {
  ApiPaths._();

  static const String root = '/';

  // USER (/user)
  static const String userAdmin = '/user/admin';
  static const String userRegister = '/user/register';
  static const String userLogin = '/user/login';

  static String userDetail(String id) => '/user/detail/$id';
  static String userBasic(String id) => '/user/basic/$id';
  static String userUpdate(String id) => '/user/update/$id';
  static String userDelete(String id) => '/user/delete/$id';

  // NOTIFICATION (/notification)
  static const String notificationAdmin = '/notification/admin';
  static const String notificationAdd = '/notification/add';

  static String notificationHistory(String userId) =>
      '/notification/history/$userId';
  static String notificationDetail(String id) => '/notification/detail/$id';
  static String notificationUpdate(String id) => '/notification/update/$id';
  static String notificationDelete(String id) => '/notification/delete/$id';

  // ATTENDANCE (/attendance)
  static const String attendanceAdmin = '/attendance/admin';
  static const String attendanceCheckIn = '/attendance/check-in';

  static String attendanceCrew(String userId) => '/attendance/crew/$userId';
  static String attendanceDetail(String id) => '/attendance/detail/$id';
  static String attendanceCheckOut(String id) => '/attendance/check-out/$id';
  static String attendanceDelete(String id) => '/attendance/delete/$id';

  // LEAVE (/leave)
  static const String leaveAdmin = '/leave/admin';
  static const String leaveAdd = '/leave/add';

  static String leaveCrew(String userId) => '/leave/crew/$userId';
  static String leaveDetail(String id) => '/leave/detail/$id';
  static String leaveUpdate(String id) => '/leave/update/$id';
  static String leaveDelete(String id) => '/leave/delete/$id';

  // OVERTIME (/overtime)
  static const String overtimeAdmin = '/overtime/admin';
  static const String overtimeAdd = '/overtime/add';

  static String overtimeCrew(String userId) => '/overtime/crew/$userId';
  static String overtimeDetail(String id) => '/overtime/detail/$id';
  static String overtimeUpdate(String id) => '/overtime/update/$id';
  static String overtimeDelete(String id) => '/overtime/delete/$id';

  // VISIT / TRACKER (/visit)
  static const String visitAdmin = '/visit/admin';
  static const String visitAdd = '/visit/add';

  static String visitDetail(String id) => '/visit/detail/$id';
  static String visitUpdate(String id) => '/visit/update/$id';
  static String visitDelete(String id) => '/visit/delete/$id';

  // Follow-up
  static String visitFollowUps(String visitId) => '/visit/$visitId/follow-up';
  static String visitFollowUpUpdate(String visitId, String followUpId) =>
      '/visit/$visitId/follow-up/$followUpId';

  // Products sold
  static String visitProductsSold(String visitId) =>
      '/visit/$visitId/products-sold';
  static String visitProductSoldById(String visitId, String productSoldId) =>
      '/visit/$visitId/products-sold/$productSoldId';

  // Units serviced
  static String visitUnitsServiced(String visitId) =>
      '/visit/$visitId/units-serviced';
  static String visitUnitServicedById(String visitId, String unitServicedId) =>
      '/visit/$visitId/units-serviced/$unitServicedId';
}
