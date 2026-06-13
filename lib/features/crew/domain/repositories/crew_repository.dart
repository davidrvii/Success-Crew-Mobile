import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../entities/crew_member.dart';

abstract class CrewRepository {
  Future<ApiResponse<List<CrewMember>>> getCrewList();
  Future<ApiResponse<UserDetail>> getCrewDetail(int userId);
  Future<ApiResponse<AttendanceHistoryData>> getCrewAttendanceHistory(int userId);
}
