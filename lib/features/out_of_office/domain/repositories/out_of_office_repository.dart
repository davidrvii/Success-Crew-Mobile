import '../../../../core/network/api_response.dart';
import '../../data/models/out_of_office_request.dart';
import '../entities/out_of_office.dart';
import '../entities/out_of_office_basic.dart';
import '../entities/out_of_office_basic_list.dart';

abstract class OutOfOfficeRepository {
  Future<ApiResponse<List<OutOfOffice>>> getOutOfOfficeList();
  Future<ApiResponse<OutOfOffice>> getOutOfOfficeDetail(int id);

  Future<ApiResponse<OutOfOffice>> createOutOfOffice(OutOfOfficeRequest request);
  Future<ApiResponse<OutOfOffice>> updateOutOfOffice(int id, OutOfOfficeRequest request);
  Future<ApiResponse<OutOfOffice>> updateOutOfOfficeStatus(int id, String status);

  Future<ApiResponse<int>> deleteOutOfOffice(int id);

  Future<ApiResponse<OutOfOfficeBasicList>> getOutOfOfficeBasicAll();
  Future<ApiResponse<OutOfOfficeBasic>> getOutOfOfficeBasicDetail(int id);
}
