import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_peanut/ui/views/dashboard_view.dart';
import 'package:test_peanut/ui/views/home_view.dart';
import 'package:test_peanut/ui/views/sign_in_view.dart';
import 'package:test_peanut/ui/widgets/simple_notification_widget.dart';

class RouteNavigation {
  static const String signIn = 'signIn';
  static const String home = 'home';
  static const String dashboard = 'dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (context) => const SignInView());

      case home:
        return MaterialPageRoute(builder: (context) => const HomeView());

      case dashboard:
        return MaterialPageRoute(builder: (context) => const DashboardView());

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}

class GlobalNavigationService {
  static GlobalKey<NavigatorState> globalNavigatorKey =
      GlobalKey<NavigatorState>();
}

Future<void> globalSignOut(int statusCode) async {
  GlobalNavigationService.globalNavigatorKey.currentState!
      .pushNamedAndRemoveUntil(RouteNavigation.signIn, (route) => false);

  final SharedPreferences preferences = await SharedPreferences.getInstance();

  simpleNotificationWidget(
    statusCode: statusCode,
    message: 'Session expired please, login again',
  );

  preferences.remove('token');
  preferences.remove('userId');
}
