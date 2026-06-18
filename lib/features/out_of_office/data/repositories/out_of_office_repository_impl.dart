import '../../../../core/network/api_response.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../../../core/storage/user_session.dart';

import '../../domain/entities/out_of_office.dart';
import '../../domain/entities/out_of_office_basic.dart';
import '../../domain/entities/out_of_office_basic_list.dart';
import '../../domain/repositories/out_of_office_repository.dart';

import '../datasources/out_of_office_remote_datasource.dart';
import '../models/out_of_office_model.dart';
import '../models/out_of_office_request.dart';

class OutOfOfficeRepositoryImpl implements OutOfOfficeRepository {
  final OutOfOfficeRemoteDataSource _remote;
  final UserSession _session;

  OutOfOfficeRepositoryImpl(this._remote, this._session);

  @override
  Future<ApiResponse<List<OutOfOffice>>> getOutOfOfficeList() async {
    final session = await _session.readSession();
    final roleName = (session?['role_name'] as String?)?.trim().toLowerCase();
    final isOwner = roleName == 'owner';

    final ApiResponse<OutOfOfficeListResponse> res;
    if (isOwner) {
      res = await _remote.getAllOutOfOffice();
    } else {
      final userIdRes = await _requireUserId();
      if (!userIdRes.isSuccess) return ApiResponse.failure(userIdRes.error!);
      final int userId = userIdRes.data!;
      res = await _remote.getOutOfOfficeList(userId);
    }

    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.items ?? const <OutOfOfficeDto>[];
    return ApiResponse.success(items.map(_mapDtoToEntity).toList());
  }

  @override
  Future<ApiResponse<OutOfOffice>> getOutOfOfficeDetail(int id) async {
    final res = await _remote.getOutOfOfficeDetail(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.detail;
    if (dto == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (out of office detail is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<OutOfOffice>> createOutOfOffice(OutOfOfficeRequest request) async {
    final ensured = await _ensureUserIdInRequest(request);

    final res = await _remote.createOutOfOffice(ensured);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.outOfOffice;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected create response (out of office is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<OutOfOffice>> updateOutOfOffice(
    int id,
    OutOfOfficeRequest request,
  ) async {
    final ensured = await _ensureUserIdInRequest(request);

    final res = await _remote.updateOutOfOffice(id, ensured);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.outOfOffice;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected update response (out of office is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<OutOfOffice>> updateOutOfOfficeStatus(
    int id,
    String status,
  ) async {
    final res = await _remote.updateOutOfOfficeStatus(id, status);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final dto = res.data?.outOfOffice;
    if (dto == null || dto.id == 0) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected status update response (out of office is null).',
        ),
      );
    }

    return ApiResponse.success(_mapDtoToEntity(dto));
  }

  @override
  Future<ApiResponse<int>> deleteOutOfOffice(int id) async {
    final res = await _remote.deleteOutOfOffice(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final deletedId = res.data?.outOfOfficeId;
    if (deletedId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected delete response (outOfOfficeId is null).',
        ),
      );
    }

    return ApiResponse.success(deletedId);
  }

  @override
  Future<ApiResponse<OutOfOfficeBasicList>> getOutOfOfficeBasicAll() async {
    final res = await _remote.getOutOfOfficeBasicAll();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final basicList = OutOfOfficeBasicList(
      outOfOffices: (res.data?.items ?? const <OutOfOfficeDto>[])
          .map(_mapDtoToEntity)
          .toList(),
      totalUnapproved: res.data?.totalUnapproved ?? 0,
    );
    return ApiResponse.success(basicList);
  }

  @override
  Future<ApiResponse<OutOfOfficeBasic>> getOutOfOfficeBasicDetail(int id) async {
    final res = await _remote.getOutOfOfficeBasicDetail(id);
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final detail = res.data?.detail;
    if (detail == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unknown,
          message: 'Unexpected response (out of office basic detail is null).',
        ),
      );
    }

    final entity = OutOfOfficeBasic(
      id: detail.id,
      status: detail.status,
      totalUnapproved: detail.totalUnapproved,
    );
    return ApiResponse.success(entity);
  }

  // ========= helpers =========

  Future<ApiResponse<int>> _requireUserId() async {
    final int? userId = await _session.readUserId();
    if (userId == null) {
      return ApiResponse.failure(
        NetworkException(
          type: NetworkErrorType.unauthorized,
          message: 'Session not found. Please login again.',
        ),
      );
    }
    return ApiResponse.success(userId);
  }

  Future<OutOfOfficeRequest> _ensureUserIdInRequest(OutOfOfficeRequest req) async {
    if (req.userId != null) return req;

    final userIdRes = await _requireUserId();
    if (!userIdRes.isSuccess) {
      return req;
    }

    final int userId = userIdRes.data!;

    return OutOfOfficeRequest(
      userId: userId,
      description: req.description,
      date: req.date,
      status: req.status,
    );
  }

  OutOfOffice _mapDtoToEntity(OutOfOfficeDto dto) {
    return OutOfOffice(
      id: dto.id,
      userId: dto.userId,
      description: dto.description,
      date: dto.date,
      status: dto.status,
      createdAt: dto.createdAt,
      updatedAt: dto.updatedAt,
      userName: dto.userName,
    );
  }
}
