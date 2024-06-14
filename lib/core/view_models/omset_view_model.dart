import 'dart:convert';

import 'package:sru/core/models/get_data/omset_piutang_get_data_dto.dart';
import 'package:sru/core/models/get_data/total_omset_piutang_get_data_dto.dart';
import 'package:sru/core/networks/omset_piutang_get_data_dto_network.dart';
import 'package:sru/core/networks/total_omset_piutang_get_data_dto_network.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OmsetViewModel extends BaseViewModel {
  OmsetViewModel({
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

  List<OmsetPiutangGetDataContent> _omset = [];
  List<OmsetPiutangGetDataContent> get omset => _omset;

  TotalOmsetPiutangGetDataContent? _totalomset;
  TotalOmsetPiutangGetDataContent? get totalomset => _totalomset;

  String? _nama;
  String? get nama => _nama;

  String? _admingrup;
  String? get admingrup => _admingrup;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fetchomset();
    await _fetchtotalomset();
    await _fecthUser();
    setBusy(false);
  }

  Future<void> _fetchomset() async {
    final response = await _omsetpiutangGetDataDTOApi.getData(
      action: "getOmzetDetail",
    );

    if (response.isRight) {
      _omset = response.right.data.data;
      notify();
    }
  }

  Future<void> _fetchtotalomset() async {
    final response = await _totalomsetpiutangGetDataDTOApi.getData(
      action: "getOmzet",
    );

    if (response.isRight) {
      _totalomset = response.right.data.data[0];
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
