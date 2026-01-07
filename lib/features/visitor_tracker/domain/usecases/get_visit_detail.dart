import '../../../../core/network/api_response.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class GetVisitDetailUseCase {
  final VisitRepository _repo;
  const GetVisitDetailUseCase(this._repo);

  Future<ApiResponse<Visit>> call(String visitId) {
    return _repo.getVisitDetail(visitId);
  }
}
