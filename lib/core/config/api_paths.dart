/// File: lib/core/config/api_paths.dart
/// Generated Documentation for api_paths.dart

/// Class defining the routing endpoints for the backend server API.
/// Organizes endpoint constants and dynamic route paths.
/// Class representing `ApiPaths`.
/// Auto-generated class documentation.
class ApiPaths {
  ApiPaths._(); // Private constructor to prevent instantiation

  static const String root = '/';

  // ─── USER ROUTES (/user) ───
  static const String userAll = '/user/all';
  static const String userRegister = '/user/register';
  static const String userLogin = '/user/login';
  static const String userCrewAll = '/user/crew/all';
  static const String userCrewAdd = '/user/crew/add';

  static String userDetail(int id) => '/user/detail/$id';
  static String userBasic(int id) => '/user/basic/$id';
  static String userUpdate(int id) => '/user/update/$id';
  static String userDelete(int id) => '/user/delete/$id';
  static String userCrewDetail(int id) => '/user/crew/$id';
  static String userCrewUpdate(int id) => '/user/crew/update/$id';

  // ─── NOTIFICATION ROUTES (/notification) ───
  static const String notificationAll = '/notification/all';
  static const String notificationAdd = '/notification/add';

  static String notificationHistory(int userId) =>
      '/notification/history/$userId';
  static String notificationDetail(int id) => '/notification/detail/$id';
  static String notificationBasic(int id) => '/notification/basic/$id';
  static String notificationRead(int id) => '/notification/read/$id';
  static String notificationUpdate(int id) => '/notification/update/$id';
  static String notificationDelete(int id) => '/notification/delete/$id';

  // ─── ATTENDANCE ROUTES (/attendance) ───
  static const String attendanceAll = '/attendance/all';
  static const String attendanceBasic = '/attendance/basic';
  static const String attendanceAdd = '/attendance/add';
  static const String attendanceCheckIn = '/attendance/checkin';
  static const String attendanceCheckOut = '/attendance/checkout';

  static String attendanceCrew(int userId) => '/attendance/crew/$userId';
  static String attendanceCrewSummary(int userId) => '/attendance/crew/summary/$userId';
  static String attendanceDetail(int id) => '/attendance/detail/$id';
  static String attendanceUpdate(int id) => '/attendance/update/$id';
  static String attendanceDelete(int id) => '/attendance/delete/$id';

  // ─── LEAVE ROUTES (/leave) ───
  static const String leaveAll = '/leave/all';
  static const String leaveAdd = '/leave/add';

  static String leaveCrew(int userId) => '/leave/crew/$userId';
  static String leaveDetail(int id) => '/leave/detail/$id';
  static String leaveUpdate(int id) => '/leave/update/$id';
  static String leaveDelete(int id) => '/leave/delete/$id';

  // ─── OVERTIME ROUTES (/overtime) ───
  static const String overtimeAll = '/overtime/all';
  static const String overtimeAdd = '/overtime/add';
  static const String overtimeBasicAll = '/overtime/basic/all';

  static String overtimeBasicDetail(int id) => '/overtime/basic/$id';
  static String overtimeCrew(int userId) => '/overtime/crew/$userId';
  static String overtimeDetail(int id) => '/overtime/detail/$id';
  static String overtimeUpdate(int id) => '/overtime/update/$id';
  static String overtimeDelete(int id) => '/overtime/delete/$id';

  // ─── OUT OF OFFICE ROUTES (/outofoffice & /out-of-office) ───
  static const String outOfOfficeAll = '/out-of-office/all';
  static const String outOfOfficeBasicAll = '/outofoffice/basic/all';
  static String outOfOfficeBasicDetail(int id) => '/outofoffice/basic/$id';
  static String outOfOfficeCrew(int userId) => '/out-of-office/crew/$userId';
  static String outOfOfficeDetail(int id) => '/out-of-office/detail/$id';
  static const String outOfOfficeAdd = '/outofoffice/add';
  static String outOfOfficeUpdatePatch(int id) => '/outofoffice/update/$id';
  static String outOfOfficeUpdatePut(int id) => '/out-of-office/update/$id';
  static String outOfOfficeDelete(int id) => '/out-of-office/delete/$id';

  // ─── VISIT / TRACKER ROUTES (/visit) ───
  static const String visitAll = '/visit/all';
  static const String visitList = '/visit/list';
  static const String visitStats = '/visit/stats';
  static const String visitAdd = '/visit/add';

  // ─── VISITOR ROUTES (/visitor) ───
  static const String visitorAll = '/visitor/all';
  static const String visitorAdd = '/visitor/add';
  static String visitorDetail(int id) => '/visitor/detail/$id';
  static String visitorUpdate(int id) => '/visitor/update/$id';
  static String visitorDelete(int id) => '/visitor/delete/$id';

  static String visitDetail(int id) => '/visit/detail/$id';
  static String visitUpdate(int id) => '/visit/update/$id';
  static String visitDelete(int id) => '/visit/delete/$id';

  // ─── FOLLOW UP ROUTES (/follow-up) ───
  static const String followUpAll = '/follow-up/all';
  static const String followUpAdd = '/follow-up/add';
  static String followUpUpdate(int followUpId) => '/follow-up/update/$followUpId';
  static String followUpDelete(int followUpId) => '/follow-up/delete/$followUpId';

  // Follow-up nested under visit
  static String visitFollowUps(int visitId) => '/follow-up/visit/$visitId';
  static String visitFollowUpById(int visitId, int followUpId) =>
      '/follow-up/visit/$visitId/$followUpId';

  // Products sold nested under visit
  static String visitProductsSold(int visitId) =>
      '/product-sold/visit/$visitId';
  static String visitProductSoldById(int visitId, int productSoldId) =>
      '/product-sold/visit/$visitId/$productSoldId';

  static const String productSoldAll = '/product-sold/all';
  static const String productSoldAdd = '/product-sold/add';
  static String productSoldUpdate(int id) => '/product-sold/update/$id';
  static String productSoldDelete(int id) => '/product-sold/delete/$id';

  // Units serviced nested under visit
  static String visitUnitsServiced(int visitId) =>
      '/unit-serviced/visit/$visitId';
  static String visitUnitServicedById(int visitId, int unitServicedId) =>
      '/unit-serviced/visit/$visitId/$unitServicedId';

  static const String unitServicedAll = '/unit-serviced/all';
  static const String unitServicedAdd = '/unit-serviced/add';
  static String unitServicedUpdate(int id) => '/unit-serviced/update/$id';
  static String unitServicedDelete(int id) => '/unit-serviced/delete/$id';
}
