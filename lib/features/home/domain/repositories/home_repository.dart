import '../../../../core/network/api_response.dart';
import '../entities/home_summary.dart';

abstract class HomeRepository {
  Future<ApiResponse<HomeSummary>> getHomeSummary();
}
