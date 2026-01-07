import '../../../../core/network/api_response.dart';
import '../../data/models/visit_request.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class UpdateVisitUseCase {
  final VisitRepository _repo;
  const UpdateVisitUseCase(this._repo);

  Future<ApiResponse<Visit>> call(String visitId, VisitRequest request) {
    return _repo.updateVisit(visitId, request);
  }
}
