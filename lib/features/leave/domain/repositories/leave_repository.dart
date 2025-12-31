import '../../../../core/network/api_response.dart';
import '../../data/models/leave_request.dart';
import '../entities/leave.dart';

abstract class LeaveRepository {
  Future<ApiResponse<List<Leave>>> getLeaveList();
  Future<ApiResponse<Leave>> getLeaveDetail(String id);

  Future<ApiResponse<Leave>> createLeave(LeaveRequest request);
  Future<ApiResponse<Leave>> updateLeave(String id, LeaveRequest request);

  Future<ApiResponse<int>> deleteLeave(String id);
}
