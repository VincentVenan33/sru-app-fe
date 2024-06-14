// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/core/services/authentication_service.dart';
import 'package:sru/core/services/navigation_service.dart';
import 'package:sru/core/view_models/base_view_model.dart';
import 'package:sru/ui/views/authentication/login_view.dart';

class SplashScreenViewModel extends BaseViewModel {
  SplashScreenViewModel({
    required NavigationService navigationService,
    required AuthenticationService authenticationService,
  })  : _navigationService = navigationService,
        _authenticationService = authenticationService;

  final NavigationService _navigationService;
  final AuthenticationService _authenticationService;

  String? _tokenFCM;
  String? get tokenFCM => _tokenFCM;

  @override
  Future<void> initModel() async {
    _navigateToMainMenu();
    // _tokenFCM = await FirebaseMessaging.instance.getToken();
  }

  void _navigateToMainMenu() async {
    final bool isLoggedIn = await _authenticationService.isLoggedIn();

    FlutterNativeSplash.remove();
    if (isLoggedIn) {
      _navigationService.popAllAndNavigateTo(
        Routes.navBarSales,
      );
      return;
    }
    _navigationService.popAllAndNavigateTo(
      Routes.login,
      arguments: LoginViewParam(
        tokenFCM: tokenFCM,
      ),
    );
  }
}
