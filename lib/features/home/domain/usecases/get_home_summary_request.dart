import '../../../../core/network/api_response.dart';
import '../entities/home_summary.dart';
import '../repositories/home_repository.dart';

class GetHomeSummaryUseCase {
  final HomeRepository _repo;
  const GetHomeSummaryUseCase(this._repo);

  Future<ApiResponse<HomeSummary>> call() {
    return _repo.getHomeSummary();
  }
}
