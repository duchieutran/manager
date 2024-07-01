import 'package:appdemo/screens/feed_screen/feed_sreen.dart';
import 'package:appdemo/screens/home/widgets/home_tabbar.dart';
import 'package:appdemo/screens/home_screen/home_screens.dart';
import 'package:appdemo/screens/profile_screen/profile_screen.dart';
import 'package:appdemo/screens/setting/setting_screen.dart';
import 'package:appdemo/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          animationDuration: const Duration(seconds: 1),
          length: 4,
          child: Scaffold(
            appBar: MainAppBar(
              fontSize: 25,
              colorLeading: Colors.black,
              kToolbarHeight: 120,
              title: 'Flutter',
              showLeading: true,
              flexiblaSpace: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromRGBO(171, 233, 241, 1),
                  Color.fromARGB(255, 58, 165, 236)
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
              ),
              bottom: const TabBar(tabs: [
                HomeTabbar(text: 'Home', icon: Icons.home),
                HomeTabbar(text: 'Feed', icon: Icons.list),
                HomeTabbar(text: 'Profile', icon: Icons.person),
                HomeTabbar(text: 'Settings', icon: Icons.settings),
              ]),
            ),
            body: const TabBarView(
              children: [
                HomeScreens(),
                FeedSreen(),
                ProfileScreen(),
                SettingScreen(),
              ],
            ),
          )),
    );
  }
}
