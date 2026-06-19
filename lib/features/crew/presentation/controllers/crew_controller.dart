/// File: lib/features/crew/presentation/controllers/crew_controller.dart
/// Generated Documentation for crew_controller.dart

import 'package:flutter/foundation.dart';
import '../../domain/entities/crew_member.dart';
import '../../domain/usecases/get_crew_list.dart';
import '../../domain/usecases/add_crew.dart';
import '../../data/models/crew_request.dart';

/// Class representing `CrewController`.
/// Auto-generated class documentation.
class CrewController extends ChangeNotifier {
  final GetCrewListUseCase _getCrewListUseCase;
  final AddCrewUseCase _addCrewUseCase;

  CrewController({
    required GetCrewListUseCase getCrewListUseCase,
    required AddCrewUseCase addCrewUseCase,
  }) : _getCrewListUseCase = getCrewListUseCase,
       _addCrewUseCase = addCrewUseCase;

  bool _isLoading = false;
  /// Getter for `isLoading` returning `bool`.
  bool get isLoading => _isLoading;

  String? _errorMessage;
  /// Getter for `errorMessage` returning `String?`.
  String? get errorMessage => _errorMessage;

  List<CrewMember> _crewList = [];
  /// Getter for `crewList` returning `List<CrewMember>`.
  List<CrewMember> get crewList => _crewList;

  /// Method `addCrew` returning `Future<bool>`.
  /// Handles logic operations related to `addCrew`.
  Future<bool> addCrew(CrewRequest request) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final res = await _addCrewUseCase(request);
    _isLoading = false;

    if (res.isSuccess) {
      await load();
      notifyListeners();
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal menambah crew.';
      notifyListeners();
      return false;
    }
  }

  /// Method `load` returning `Future<void>`.
  /// Handles logic operations related to `load`.
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

  /// Method `refresh` returning `Future<void>`.
  /// Handles logic operations related to `refresh`.
  Future<void> refresh() => load();
}
