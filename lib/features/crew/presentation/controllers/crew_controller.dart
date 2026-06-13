import 'package:flutter/foundation.dart';
import '../../domain/entities/crew_member.dart';
import '../../domain/usecases/get_crew_list.dart';

class CrewController extends ChangeNotifier {
  final GetCrewListUseCase _getCrewListUseCase;

  CrewController({
    required GetCrewListUseCase getCrewListUseCase,
  }) : _getCrewListUseCase = getCrewListUseCase;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<CrewMember> _crewList = [];
  List<CrewMember> get crewList => _crewList;

  Future<void> load() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final res = await _getCrewListUseCase();
    if (res.isSuccess && res.data != null) {
      _crewList = res.data!;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memuat data crew.';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() => load();
}
