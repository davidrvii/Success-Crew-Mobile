import '../../../../core/network/api_response.dart';
import '../../../attendance/domain/entities/attendance.dart';
import '../repositories/crew_repository.dart';

class GetCrewAttendanceHistoryUseCase {
  final CrewRepository _repository;
  GetCrewAttendanceHistoryUseCase(this._repository);

  Future<ApiResponse<AttendanceHistoryData>> call(int userId) {
    return _repository.getCrewAttendanceHistory(userId);
  }
}
