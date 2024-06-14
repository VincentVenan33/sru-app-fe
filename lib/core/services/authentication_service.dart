import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/models/authentication/login.dart';
import 'package:sru/core/services/navigation_service.dart';
import 'package:sru/core/services/shared_preferences_service.dart';
import 'package:sru/ui/views/authentication/login_view.dart';

final Provider<AuthenticationService> authProvider = Provider<AuthenticationService>(
  (ProviderRef<AuthenticationService> ref) {
    return AuthenticationService(
      navigationService: ref.watch(navigationProvider),
      sharedPreferencesService: ref.watch(sharedPrefProvider),
    );
  },
);

class AuthenticationService {
  AuthenticationService({
    required SharedPreferencesService sharedPreferencesService,
    required NavigationService navigationService,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _navigationService = navigationService;

  final SharedPreferencesService _sharedPreferencesService;
  final NavigationService _navigationService;

  Future<bool> isLoggedIn() async {
    final LoginResponseData? login = await _sharedPreferencesService.get(
      SharedPrefKeys.tokenLogin,
    );
    debugPrint(login?.token);
    return login?.token != null;
  }

  Future<bool> logout() async {
    try {
      await _sharedPreferencesService.clearStorage();
      _navigationService.navigatePopAllAndNavigateToRoute(
        MaterialPageRoute<dynamic>(
          builder: (_) => LoginView(
            param: LoginViewParam(),
          ),
        ),
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  // Future<bool> checkTokenValidity() async {
  //   final LoginResultResponse loginResponse =
  //       await _sharedPreferencesService.get(
  //     SharedPrefKeys.userCredential,
  //   );
  //   if (loginResponse.accessToken.isNotEmpty) {
  //     return true;
  //   }
  //   return false;
  // }

  // Future<String?> getAccountId() async {
  //   final UserData? userData = await _sharedPreferencesService.get(
  //     SharedPrefKeys.userData,
  //   );
  //   return userData?.accountId;
  // }

  Future<UserData?> getUserData() async {
    final UserData? userData = await _sharedPreferencesService.get(
      SharedPrefKeys.userData,
    );
    return userData;
  }

  // Future<String?> getJwtToken() async {
  //   final LoginResultResponse loginResponse =
  //       await _sharedPreferencesService.get(
  //     SharedPrefKeys.userCredential,
  //   );

  //   if (await checkTokenValidity()) {
  //     return loginResponse.accessToken;
  //   }
  //   logout();
  //   return null;
  // }
}
