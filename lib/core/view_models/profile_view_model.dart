import 'dart:convert';

import 'package:mjk_apps/core/services/authentication_service.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileModel extends BaseViewModel {
  ProfileModel({
    required AuthenticationService authenticationService,
    required SharedPreferencesService sharedPreferencesService,
  })  : _authenticationService = authenticationService,
        _sharedPreferencesService = sharedPreferencesService;

  final AuthenticationService _authenticationService;
  // ignore: unused_field
  final SharedPreferencesService _sharedPreferencesService;

  String? _nama;
  String? get nama => _nama;

  String? _admingrup;
  String? get admingrup => _admingrup;

  @override
  Future<void> initModel() async {
    setBusy(true);
    await _fecthUser();
    setBusy(false);
  }

  // Add a method to handle login from shared preference
  // bool _isLoggedIn = false;
  // bool get isLoggedIn => _isLoggedIn;

  Future<void> _fecthUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataJson = prefs.getString(SharedPrefKeys.userData.label);
    _nama = json.decode(userDataJson!)['nama'];
    _admingrup = json.decode(userDataJson)['admingrup'];
  }

  Future<bool> requestLogout() async {
    // ignore: unused_local_variable
    final response = await _authenticationService.logout();

    return true;
  }
}
