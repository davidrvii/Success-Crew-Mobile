import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/overtime.dart';
import '../../domain/repositories/overtime_repository.dart';

import '../datasources/overtime_remote_datasource.dart';
import '../models/overtime_model.dart';
import '../models/overtime_request.dart';

class OvertimeRepositoryImpl implements OvertimeRepository {
  final OvertimeRemoteDataSource _remote;
  final UserSession _session;

  OvertimeRepositoryImpl(this._remote, this._session);

  @override
  Future<ApiResponse<List<Overtime>>> getOvertimeList() async {
    final userId = await _requireUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }

    final res = await _remote.getOvertimeList(userId);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.items ?? const <OvertimeDto>[];
    return ApiResponse.success(items.map(_mapDtoToEntity).toList());
  }

  @override
  Future<ApiResponse<Overtime>> getOvertimeDetail(String id) async {
    final res = await _remote.getOvertimeDetail(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.detail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (overtime detail is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<Overtime>> createOvertime(OvertimeRequest request) async {
    final ensured = await _ensureUserIdInRequest(request);

    final res = await _remote.createOvertime(ensured);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.overtime;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected create response (overtime is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<Overtime>> updateOvertime(
    String id,
    OvertimeRequest request,
  ) async {
    final ensured = await _ensureUserIdInRequest(request);

    final res = await _remote.updateOvertime(id, ensured);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.overtime;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected update response (overtime is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<int>> deleteOvertime(String id) async {
    final res = await _remote.deleteOvertime(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final deletedId = res.data?.overtimeId;
    if (deletedId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected delete response (overtimeId is null).',
        ),
      );
    }

    return ApiResponse.success(deletedId);
  }

  // ========= helpers =========

  Future<String?> _requireUserId() async {
    final session = await _session.readSession();
    final userId = session?['user_id']?.toString();
    if (userId == null || userId.isEmpty) return null;
    return userId;
  }

  Future<OvertimeRequest> _ensureUserIdInRequest(OvertimeRequest req) async {
    if (req.userId != null) return req;

    final userIdStr = await _requireUserId();
    final userId = int.tryParse(userIdStr ?? '');
    if (userId == null) return req;

    return OvertimeRequest(
      userId: userId,
      overtimeDate: req.overtimeDate,
      startTime: req.startTime,
      endTime: req.endTime,
      reason: req.reason,
      status: req.status,
    );
  }

  Overtime _mapDtoToEntity(OvertimeDto dto) {
    return Overtime(
      id: dto.id,
      userId: dto.userId,
      overtimeDate: dto.overtimeDate,
      startTime: dto.startTime,
      endTime: dto.endTime,
      reason: dto.reason,
      status: dto.status,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
    );
  }
}
