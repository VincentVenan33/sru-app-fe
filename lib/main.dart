import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sru/core/app_constants/route.dart';
import 'package:sru/router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await dotenv.load(fileName: 'assets/cfg/base.env');

  // await Firebase.initializeApp();

  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SRU App',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: Routes.splashScreen,
      navigatorKey: navigatorKey,
      builder: BotToastInit(),
      navigatorObservers: <NavigatorObserver>[
        routeObserver,
        BotToastNavigatorObserver(),
      ],
    );
  }
}
