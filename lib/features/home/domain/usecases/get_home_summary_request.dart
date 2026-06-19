/// File: lib/features/home/domain/usecases/get_home_summary_request.dart
/// Generated Documentation for get_home_summary_request.dart

import '../../../../core/network/api_response.dart';
import '../entities/home_summary.dart';
import '../repositories/home_repository.dart';

/// Class representing `GetHomeSummaryUseCase`.
/// Auto-generated class documentation.
class GetHomeSummaryUseCase {
  final HomeRepository _repo;
  const GetHomeSummaryUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<HomeSummary>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<HomeSummary>> call() {
    return _repo.getHomeSummary();
  }
}
