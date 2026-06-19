import 'package:flutter/material.dart';

import '../../domain/entities/out_of_office.dart';
import '../../domain/usecases/get_out_of_office_list.dart';
import '../../domain/usecases/create_out_of_office.dart';
import '../../domain/usecases/update_out_of_office.dart';
import '../../domain/usecases/delete_out_of_office.dart';
import '../../data/models/out_of_office_request.dart';
import '../../../../core/storage/user_session.dart';

class OutOfOfficeController extends ChangeNotifier {
  final GetOutOfOfficeListUseCase _getOutOfOfficeList;
  final CreateOutOfOfficeUseCase _createOutOfOffice;
  final UpdateOutOfOfficeUseCase _updateOutOfOffice;
  final DeleteOutOfOfficeUseCase _deleteOutOfOffice;
  final UserSession _session;

  OutOfOfficeController({
    required GetOutOfOfficeListUseCase getOutOfOfficeList,
    required CreateOutOfOfficeUseCase createOutOfOffice,
    required UpdateOutOfOfficeUseCase updateOutOfOffice,
    required DeleteOutOfOfficeUseCase deleteOutOfOffice,
    required UserSession userSession,
  }) : _getOutOfOfficeList = getOutOfOfficeList,
       _createOutOfOffice = createOutOfOffice,
       _updateOutOfOffice = updateOutOfOffice,
       _deleteOutOfOffice = deleteOutOfOffice,
       _session = userSession;

  bool _loading = false;
  bool get isLoading => _loading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<OutOfOffice> _outOfOffices = [];
  List<OutOfOffice> get outOfOffices => _outOfOffices;

  bool _isOwner = false;
  bool get isOwner => _isOwner;

  Future<void> init() async {
    final session = await _session.readSession();
    final role = (session?['role_name'] as String?)?.trim().toLowerCase();
    _isOwner = role == 'owner';
    notifyListeners();
    await fetchOutOfOffices();
  }

  Future<void> fetchOutOfOffices() async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _getOutOfOfficeList();

    if (res.isSuccess) {
      _outOfOffices = res.data ?? [];
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memuat data dinas luar';
    }

    _setLoading(false);
  }

  Future<bool> submitOutOfOffice({
    required String date,
    required String description,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    final req = OutOfOfficeRequest(
      date: date,
      description: description,
      status: 'pending',
    );

    final res = await _createOutOfOffice(req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOutOfOffices(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal mengajukan dinas luar';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateStatus(int id, String status) async {
    _setLoading(true);
    _errorMessage = null;

    final req = OutOfOfficeRequest(status: status);
    final res = await _updateOutOfOffice(id, req);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOutOfOffices(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal memperbarui status dinas luar';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteOutOfOffice(int id) async {
    _setLoading(true);
    _errorMessage = null;

    final res = await _deleteOutOfOffice(id);

    _setLoading(false);

    if (res.isSuccess) {
      fetchOutOfOffices(); // Refresh data after success
      return true;
    } else {
      _errorMessage = res.error?.message ?? 'Gagal menghapus dinas luar';
      notifyListeners();
      return false;
    }
  }

  void _setLoading(bool v) {
    if (_loading == v) return;
    _loading = v;
    notifyListeners();
  }
}
