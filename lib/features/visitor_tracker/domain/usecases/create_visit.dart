import '../../../../core/network/api_response.dart';
import '../../data/models/visit_request.dart';
import '../entities/visit.dart';
import '../repositories/visit_repository.dart';

class CreateVisitUseCase {
  final VisitRepository _repo;
  const CreateVisitUseCase(this._repo);

  Future<ApiResponse<Visit>> call(VisitRequest request) {
    return _repo.createVisit(request);
  }
}
