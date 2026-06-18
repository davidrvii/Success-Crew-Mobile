import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../entities/crew_member.dart';
import '../../data/models/crew_request.dart';

abstract class CrewRepository {
  Future<ApiResponse<List<CrewMember>>> getCrewList();
  Future<ApiResponse<List<CrewMember>>> getAllUsers();
  Future<ApiResponse<UserDetail>> getCrewDetail(int userId);
  Future<ApiResponse<AttendanceHistoryData>> getCrewAttendanceHistory(int userId);
  Future<ApiResponse<UserDetail>> addCrew(CrewRequest request);
  Future<ApiResponse<UserDetail>> updateCrew(int userId, CrewRequest request);
  Future<ApiResponse<int>> deleteUser(int userId);
}
