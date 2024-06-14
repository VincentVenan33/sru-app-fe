import 'package:flutter/material.dart';
import 'package:mjk_apps/core/app_constants/route.dart';
import 'package:mjk_apps/core/models/authentication/login.dart';
import 'package:mjk_apps/core/networks/authentication_network.dart';
import 'package:mjk_apps/core/services/authentication_service.dart';
import 'package:mjk_apps/core/services/navigation_service.dart';
import 'package:mjk_apps/core/services/shared_preferences_service.dart';
import 'package:mjk_apps/core/view_models/base_view_model.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel({
    required AuthenticationApiService authenticationApi,
    required AuthenticationService authenticationService,
    required SharedPreferencesService sharedPreferencesService,
    required NavigationService navigationService,
  })  : _authenticationApi = authenticationApi,
        _authenticationService = authenticationService,
        _sharedPreferencesService = sharedPreferencesService,
        _navigationService = navigationService;

  final AuthenticationApiService _authenticationApi;
  // ignore: unused_field
  final AuthenticationService _authenticationService;
  final SharedPreferencesService _sharedPreferencesService;
  final NavigationService _navigationService;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //  Add a method to handle login from shared preference
  // bool _isLoggedIn = false;
  // bool get isLoggedIn => _isLoggedIn;

  @override
  Future<void> initModel() async {
    setBusy(true);
    //await getLoggedInStatus();
    setBusy(false);
  }

  Future<void> getLoggedInStatus() async {
    _navigationService.popAllAndNavigateTo(
      Routes.dashboard,
    );
    // bool isLoggedIn = await _authenticationService.isLoggedIn();
    // if (isLoggedIn) {
    //   _navigationService.popAllAndNavigateTo(
    //     Routes.dashboard,
    //   );
    // } else {
    //   _navigationService.popAllAndNavigateTo(
    //     Routes.login,
    //   );
    // }
    // notifyListeners();
  }

  Future<bool> requestLogin() async {
    // beri if untuk owner / sales
    final response = await _authenticationApi.login(
      kode: usernameController.text,
      sandi: passwordController.text,
    );

    if (response.isRight) {
      // navigate to dashboard
      final LoginResponseData tokenLogin = response.right.data;
      final UserData newUserData = response.right.data.user;
      // if (newUserData.jenisUser == "owner") {}
      await _sharedPreferencesService.set(SharedPrefKeys.tokenLogin, tokenLogin);
      await _sharedPreferencesService.set(SharedPrefKeys.userData, newUserData);
      return true;
    }

    return false;
    // return true;
  }
}
