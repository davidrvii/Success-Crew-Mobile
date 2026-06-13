import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';
import '../../../profile/data/models/user_detail_model.dart';
import '../../../attendance/data/models/attendance_model.dart';
import '../models/crew_member_model.dart';

abstract class CrewRemoteDataSource {
  Future<ApiResponse<CrewListResponse>> getCrewList();
  Future<ApiResponse<UserDetailResponse>> getCrewDetail(int userId);
  Future<ApiResponse<AttendanceListResponse>> getCrewAttendanceHistory(int userId);
}

class CrewRemoteDataSourceImpl implements CrewRemoteDataSource {
  final DioClient _client;
  CrewRemoteDataSourceImpl(this._client);

  @override
  Future<ApiResponse<CrewListResponse>> getCrewList() {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userAdmin),
      parser: (json) => CrewListResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<UserDetailResponse>> getCrewDetail(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.userDetail(userId)),
      parser: (json) => UserDetailResponse.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<ApiResponse<AttendanceListResponse>> getCrewAttendanceHistory(int userId) {
    return ApiResponse.guard(
      request: () => _client.get(ApiPaths.attendanceCrew(userId)),
      parser: (json) => AttendanceListResponse.fromJson(json as Map<String, dynamic>),
    );
  }
}

