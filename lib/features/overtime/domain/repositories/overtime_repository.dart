import '../../../../core/network/api_response.dart';
import '../../data/models/overtime_request.dart';
import '../entities/overtime.dart';

abstract class OvertimeRepository {
  Future<ApiResponse<List<Overtime>>> getOvertimeList();
  Future<ApiResponse<Overtime>> getOvertimeDetail(int id);

  Future<ApiResponse<Overtime>> createOvertime(OvertimeRequest request);
  Future<ApiResponse<Overtime>> updateOvertime(int id, OvertimeRequest request);

  Future<ApiResponse<int>> deleteOvertime(int id);
}
