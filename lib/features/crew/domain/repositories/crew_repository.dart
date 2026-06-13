import '../../../../core/network/api_response.dart';
import '../entities/crew_member.dart';

abstract class CrewRepository {
  Future<ApiResponse<List<CrewMember>>> getCrewList();
}
