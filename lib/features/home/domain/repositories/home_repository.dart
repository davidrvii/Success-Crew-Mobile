/// File: lib/features/home/domain/repositories/home_repository.dart
/// Generated Documentation for home_repository.dart

import '../../../../core/network/api_response.dart';
import '../entities/home_summary.dart';

abstract class HomeRepository {
  /// Method `getHomeSummary` returning `Future<ApiResponse<HomeSummary>>`.
  /// Handles logic operations related to `getHomeSummary`.
  Future<ApiResponse<HomeSummary>> getHomeSummary();
}
