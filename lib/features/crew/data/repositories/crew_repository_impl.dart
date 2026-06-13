import '../../../../core/network/api_response.dart';
import '../../domain/entities/crew_member.dart';
import '../../domain/repositories/crew_repository.dart';
import '../datasources/crew_remote_datasource.dart';
import '../models/crew_member_model.dart';

class CrewRepositoryImpl implements CrewRepository {
  final CrewRemoteDataSource _remote;
  CrewRepositoryImpl(this._remote);

  @override
  Future<ApiResponse<List<CrewMember>>> getCrewList() async {
    final res = await _remote.getCrewList();
    if (!res.isSuccess) return ApiResponse.failure(res.error!);

    final items = res.data?.users ?? const <CrewMemberDto>[];
    final mapped = items.map((dto) => CrewMember(
      userId: dto.userId,
      userName: dto.userName,
      userEmail: dto.userEmail,
      userPhoto: dto.userPhoto,
      roleName: dto.roleName,
      officeName: dto.officeName,
    )).toList();

    return ApiResponse.success(mapped);
  }
}
