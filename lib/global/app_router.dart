import 'package:appdemo/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
        builder: (context) => makeRoute(
            context: context,
            nameRoute: settings.name!,
            arguments: settings.arguments));
  }

  static makeRoute(
      {required BuildContext context,
      required String nameRoute,
      Object? arguments}) {
    switch (nameRoute) {
      case login:
        return LoginScreen();
    }
  }

  static const String login = '/';
}
