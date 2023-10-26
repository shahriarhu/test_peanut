import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/locator.dart';
import 'package:test_peanut/ui/route_navigation.dart';
import 'package:test_peanut/ui/shared/theme_provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  final SharedPreferences preferences = await SharedPreferences.getInstance();
  String? isSignedIn = preferences.getString('token');

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: BotToastInit(),
      navigatorKey: GlobalNavigationService.globalNavigatorKey,
      navigatorObservers: [
        BotToastNavigatorObserver(),
      ],
      theme: CustomThemeProvider.customLightTheme,
      title: 'Peanut',
      initialRoute:
          isSignedIn == null ? RouteNavigation.signIn : RouteNavigation.home,
      onGenerateRoute: RouteNavigation.generateRoute,
    ),
  );
}
