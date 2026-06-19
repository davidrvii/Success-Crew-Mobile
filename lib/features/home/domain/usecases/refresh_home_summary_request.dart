/// File: lib/features/home/domain/usecases/refresh_home_summary_request.dart
/// Generated Documentation for refresh_home_summary_request.dart

import '../../../../core/network/api_response.dart';
import '../entities/home_summary.dart';
import '../repositories/home_repository.dart';

/// Class representing `RefreshHomeSummaryUseCase`.
/// Auto-generated class documentation.
class RefreshHomeSummaryUseCase {
  final HomeRepository _repo;
  const RefreshHomeSummaryUseCase(this._repo);

  /// Method `call` returning `Future<ApiResponse<HomeSummary>>`.
  /// Handles logic operations related to `call`.
  Future<ApiResponse<HomeSummary>> call() {
    return _repo.getHomeSummary();
  }
}
