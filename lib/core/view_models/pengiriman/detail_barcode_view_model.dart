import 'dart:convert';

import 'package:mjk_apps/core/models/get_data/nota_jual_get_data_dto.dart';
import 'package:mjk_apps/core/networks/nota_jual_get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/update_nota_jual_dto.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailBarcodeViewModel extends BaseViewModel {
  DetailBarcodeViewModel({
    required NotaJualGetDataDTOService notaJualGetDataDTOApi,
    required SetUpdateNotaJualDTOService setUpdateNotaJualDTOApi,
    required int nomor,
  })  : _notaJualGetDataDTOApi = notaJualGetDataDTOApi,
        _setUpdateNotaJualDTOApi = setUpdateNotaJualDTOApi,
        _nomor = nomor;

  final NotaJualGetDataDTOService _notaJualGetDataDTOApi;
  final SetUpdateNotaJualDTOService _setUpdateNotaJualDTOApi;
  final int _nomor;

  List<NotaJualGetDataContent> _notajual = [];
  List<NotaJualGetDataContent> get notajual => _notajual;

  String? _nama;
  String? get nama => _nama;

  String? _admingrup;
  String? get admingrup => _admingrup;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchNotaJual();
    await _fecthUser();
    setBusy(false);
  }

  // ignore: unused_element
  Future<void> _fetchNotaJual({bool reload = false}) async {
    final filters = NotaJualGetFilter(
      nomor: _nomor,
    );

    final response = await _notaJualGetDataDTOApi.getData(
      action: "getNotaJual",
      filters: filters,
    );

    if (response.isRight) {
      _notajual = response.right.data.data;
      notify();
    }
  }

  Future<void> _fecthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    _nama = json.decode(userDataJson!)['nama'];
    _admingrup = json.decode(userDataJson)['admingrup'];
  }

  Future<bool> updateNotaJual({
    required double longitude,
    required double latitude,
    required String mode,
    required int nomormhadmin,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    final response = await _setUpdateNotaJualDTOApi.setUpdateNotaJual(
      action: "updateNotaJual",
      longitude: longitude,
      latitude: latitude,
      mode: mode,
      nomor: _nomor,
      nomormhadmin: json.decode(userDataJson!)['nomor'],
    );
    if (response.isRight) {
      return true;
    }
    return false;
  }
}
