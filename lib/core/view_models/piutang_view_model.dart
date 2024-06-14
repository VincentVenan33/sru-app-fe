import 'dart:convert';

import 'package:mjk_apps/core/models/get_data/omset_piutang_get_data_dto.dart';
import 'package:mjk_apps/core/models/get_data/total_omset_piutang_get_data_dto.dart';
import 'package:mjk_apps/core/networks/omset_piutang_get_data_dto_network.dart';
import 'package:mjk_apps/core/networks/total_omset_piutang_get_data_dto_network.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PiutangViewModel extends BaseViewModel {
  PiutangViewModel({
    required OmsetPiutangGetDataDTOService omsetpiutangGetDataDTOApi,
    required TotalOmsetPiutangGetDataDTOService totalomsetpiutangGetDataDTOApi,
    required SharedPreferencesService sharedPreferencesService,
  })  : _omsetpiutangGetDataDTOApi = omsetpiutangGetDataDTOApi,
        _totalomsetpiutangGetDataDTOApi = totalomsetpiutangGetDataDTOApi,
         _sharedPreferencesService = sharedPreferencesService;

  final OmsetPiutangGetDataDTOService _omsetpiutangGetDataDTOApi;
  final TotalOmsetPiutangGetDataDTOService _totalomsetpiutangGetDataDTOApi;
  // ignore: unused_field
  final SharedPreferencesService _sharedPreferencesService;

  List<OmsetPiutangGetDataContent> _piutang = [];
  List<OmsetPiutangGetDataContent> get piutang => _piutang;

  TotalOmsetPiutangGetDataContent? _totalpiutang;
  TotalOmsetPiutangGetDataContent? get totalpiutang => _totalpiutang;

  String? _nama;
  String? get nama => _nama;

  String? _admingrup;
  String? get admingrup => _admingrup;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchpiutang();
    await _fetchtotalpiutang();
    await _fecthUser();
    setBusy(false);
  }

  Future<void> _fetchpiutang() async {
    final response = await _omsetpiutangGetDataDTOApi.getData(
      action: "getPiutangDetail",
    );

    if (response.isRight) {
      _piutang = response.right.data.data;
      notify();
    }
  }

  Future<void> _fetchtotalpiutang() async {
    final response = await _totalomsetpiutangGetDataDTOApi.getData(
      action: "getPiutang",
    );

    if (response.isRight) {
      _totalpiutang = response.right.data.data[0];
      notify();
    }
  }

  Future<void> _fecthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    _nama = json.decode(userDataJson!)['nama'];
    _admingrup = json.decode(userDataJson)['admingrup'];
  }
}
