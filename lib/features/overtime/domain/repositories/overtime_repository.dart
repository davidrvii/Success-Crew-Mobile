/// File: lib/features/overtime/domain/repositories/overtime_repository.dart
/// Generated Documentation for overtime_repository.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/overtime_request.dart';
import '../entities/overtime.dart';
import '../entities/overtime_basic.dart';
import '../entities/overtime_basic_list.dart';

abstract class OvertimeRepository {
  /// Method `getOvertimeList` returning `Future<ApiResponse<List<Overtime>>>`.
  /// Handles logic operations related to `getOvertimeList`.
  Future<ApiResponse<List<Overtime>>> getOvertimeList();
  /// Method `getOvertimeDetail` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `getOvertimeDetail`.
  Future<ApiResponse<Overtime>> getOvertimeDetail(int id);

  /// Method `createOvertime` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `createOvertime`.
  Future<ApiResponse<Overtime>> createOvertime(OvertimeRequest request);
  /// Method `updateOvertime` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `updateOvertime`.
  Future<ApiResponse<Overtime>> updateOvertime(int id, OvertimeRequest request);
  /// Method `updateOvertimeStatus` returning `Future<ApiResponse<Overtime>>`.
  /// Handles logic operations related to `updateOvertimeStatus`.
  Future<ApiResponse<Overtime>> updateOvertimeStatus(int id, String status);

  /// Method `deleteOvertime` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteOvertime`.
  Future<ApiResponse<int>> deleteOvertime(int id);

  /// Method `getOvertimeBasicAll` returning `Future<ApiResponse<OvertimeBasicList>>`.
  /// Handles logic operations related to `getOvertimeBasicAll`.
  Future<ApiResponse<OvertimeBasicList>> getOvertimeBasicAll();
  /// Method `getOvertimeBasicDetail` returning `Future<ApiResponse<OvertimeBasic>>`.
  /// Handles logic operations related to `getOvertimeBasicDetail`.
  Future<ApiResponse<OvertimeBasic>> getOvertimeBasicDetail(int id);
}
