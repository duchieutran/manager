import 'package:appdemo/models/model_user.dart';
import 'package:appdemo/screens/home/home.dart';
import 'package:appdemo/screens/login/login_screen.dart';
import 'package:appdemo/screens/show_info/show_info.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => makeRoute(
            context: context,
            nameRoute: settings.name!,
            agruments: settings.arguments));
  }

  static makeRoute(
      {required String nameRoute,
      required BuildContext context,
      Object? agruments}) {
    switch (nameRoute) {
      case login:
        return LoginScreen();
      case home:
        return const Home();
      case showinfo:
        return ShowInfo(
          user: agruments as ModelUser,
        );
      default:
        throw "Route $nameRoute is not define";
    }
  }

  // define named route
  static const String login = '/';
  static const String home = '/home';
  static const String showinfo = '/showinfo';
}
