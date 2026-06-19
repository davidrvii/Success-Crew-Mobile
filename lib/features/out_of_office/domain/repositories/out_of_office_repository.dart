/// File: lib/features/out_of_office/domain/repositories/out_of_office_repository.dart
/// Generated Documentation for out_of_office_repository.dart

import '../../../../core/network/api_response.dart';
import '../../data/models/out_of_office_request.dart';
import '../entities/out_of_office.dart';
import '../entities/out_of_office_basic.dart';
import '../entities/out_of_office_basic_list.dart';

abstract class OutOfOfficeRepository {
  /// Method `getOutOfOfficeList` returning `Future<ApiResponse<List<OutOfOffice>>>`.
  /// Handles logic operations related to `getOutOfOfficeList`.
  Future<ApiResponse<List<OutOfOffice>>> getOutOfOfficeList();
  /// Method `getOutOfOfficeDetail` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `getOutOfOfficeDetail`.
  Future<ApiResponse<OutOfOffice>> getOutOfOfficeDetail(int id);

  /// Method `createOutOfOffice` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `createOutOfOffice`.
  Future<ApiResponse<OutOfOffice>> createOutOfOffice(OutOfOfficeRequest request);
  /// Method `updateOutOfOffice` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `updateOutOfOffice`.
  Future<ApiResponse<OutOfOffice>> updateOutOfOffice(int id, OutOfOfficeRequest request);
  /// Method `updateOutOfOfficeStatus` returning `Future<ApiResponse<OutOfOffice>>`.
  /// Handles logic operations related to `updateOutOfOfficeStatus`.
  Future<ApiResponse<OutOfOffice>> updateOutOfOfficeStatus(int id, String status);

  /// Method `deleteOutOfOffice` returning `Future<ApiResponse<int>>`.
  /// Handles logic operations related to `deleteOutOfOffice`.
  Future<ApiResponse<int>> deleteOutOfOffice(int id);

  /// Method `getOutOfOfficeBasicAll` returning `Future<ApiResponse<OutOfOfficeBasicList>>`.
  /// Handles logic operations related to `getOutOfOfficeBasicAll`.
  Future<ApiResponse<OutOfOfficeBasicList>> getOutOfOfficeBasicAll();
  /// Method `getOutOfOfficeBasicDetail` returning `Future<ApiResponse<OutOfOfficeBasic>>`.
  /// Handles logic operations related to `getOutOfOfficeBasicDetail`.
  Future<ApiResponse<OutOfOfficeBasic>> getOutOfOfficeBasicDetail(int id);
}
