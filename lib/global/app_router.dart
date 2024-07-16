import 'package:appdemo/screens/add_info/add_info.dart';
import 'package:appdemo/screens/edit_info/edit_info.dart';
import '../models/model_user.dart';
import '../screens/home/home.dart';
import '../screens/login/login_screen.dart';
import '../screens/show_info/show_info.dart';
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
      case editinfo:
        return EditInfo(
          user: agruments as ModelUser,
        );
      case addinfo:
        return const AddInfo();
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
  static const String editinfo = '/editinfo';
  static const String addinfo = '/addinfo';
}
