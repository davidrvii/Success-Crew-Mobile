/// File: lib/features/crew/domain/repositories/crew_repository.dart
/// Generated Documentation for crew_repository.dart

import '../../../../core/network/api_response.dart';
import '../../../profile/domain/entities/user_detail.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../entities/crew_member.dart';
import '../../data/models/crew_request.dart';

abstract class CrewRepository {
  /// Method `getCrewList` returning `Future<ApiResponse<List<CrewMember>>>`.
  /// Handles logic operations related to `getCrewList`.
  Future<ApiResponse<List<CrewMember>>> getCrewList();
  /// Method `getAllUsers` returning `Future<ApiResponse<List<CrewMember>>>`.
  /// Handles logic operations related to `getAllUsers`.
  Future<ApiResponse<List<CrewMember>>> getAllUsers();
  /// Method `getCrewDetail` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `getCrewDetail`.
  Future<ApiResponse<UserDetail>> getCrewDetail(int userId);
  /// Method `getCrewAttendanceHistory` returning `Future<ApiResponse<AttendanceHistoryData>>`.
  /// Handles logic operations related to `getCrewAttendanceHistory`.
  Future<ApiResponse<AttendanceHistoryData>> getCrewAttendanceHistory(int userId);
  /// Method `addCrew` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `addCrew`.
  Future<ApiResponse<UserDetail>> addCrew(CrewRequest request);
  /// Method `updateCrew` returning `Future<ApiResponse<UserDetail>>`.
  /// Handles logic operations related to `updateCrew`.
  Future<ApiResponse<UserDetail>> updateCrew(int userId, CrewRequest request);
  /// Method `deleteUser` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteUser`.
  Future<ApiResponse<int>> deleteUser(int userId);
}
