/// File: lib/features/leave/domain/repositories/leave_repository.dart
/// Generated Documentation for leave_repository.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/leave_request.dart';
import '../entities/leave.dart';

abstract class LeaveRepository {
  /// Method `getLeaveList` returning `Future<ApiResponse<List<Leave>>>`.
  /// Handles logic operations related to `getLeaveList`.
  Future<ApiResponse<List<Leave>>> getLeaveList();
  /// Method `getLeaveDetail` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `getLeaveDetail`.
  Future<ApiResponse<Leave>> getLeaveDetail(int id);

  /// Method `createLeave` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `createLeave`.
  Future<ApiResponse<Leave>> createLeave(LeaveRequest request);
  /// Method `updateLeave` returning `Future<ApiResponse<Leave>>`.
  /// Handles logic operations related to `updateLeave`.
  Future<ApiResponse<Leave>> updateLeave(int id, LeaveRequest request);

  /// Method `deleteLeave` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteLeave`.
  Future<ApiResponse<int>> deleteLeave(int id);
}
