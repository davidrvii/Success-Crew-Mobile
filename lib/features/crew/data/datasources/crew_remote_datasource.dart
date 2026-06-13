import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/dio_client.dart';
import '../models/crew_member_model.dart';

abstract class CrewRemoteDataSource {
  Future<ApiResponse<CrewListResponse>> getCrewList();
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
}
