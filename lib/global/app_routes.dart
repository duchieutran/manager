import 'package:appdemo/screens/home/home.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
        builder: (BuildContext context) => makeRoute(
            context: context,
            routeName: settings.name!,
            agruments: settings.arguments));
  }

  static makeRoute(
      {required BuildContext context,
      required String routeName,
      Object? agruments}) {
    switch (routeName) {
      case homeSreen:
        const Home();
      // case login:
      //   const Login();
    }
  }

  static const String homeSreen = '/';
  // final String login = '/login';
}
