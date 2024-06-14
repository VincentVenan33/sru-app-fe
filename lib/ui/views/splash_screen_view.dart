import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mjk_apps/core/services/authentication_service.dart';
import 'package:mjk_apps/core/services/navigation_service.dart';
import 'package:mjk_apps/core/view_models/splash_screen_view_model.dart';
import 'package:mjk_apps/core/view_models/view_model.dart';

class SplashScreenView extends ConsumerWidget {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return ViewModel<SplashScreenViewModel>(
        model: SplashScreenViewModel(
          navigationService: ref.read(navigationProvider),
          authenticationService: ref.read(authProvider),
        ),
        onModelReady: (SplashScreenViewModel model) => model.initModel(),
        builder: (_, SplashScreenViewModel model, __) {
          final Size windowSize = MediaQuery.of(context).size;
          return Scaffold(
            body: Container(
              width: windowSize.width,
              height: windowSize.height,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/mjk-logo.png',
                  ),
                  fit: BoxFit.none,
                ),
              ),
            ),
          );
        });
  }
}
