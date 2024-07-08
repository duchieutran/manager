import 'home_tabfeed/feed_sreen.dart';
import 'widgets/home_tabbar.dart';
import 'home_tabhome/home_screens.dart';
import 'home_tabprofile/profile_screen.dart';
import 'home_tabsetting/setting_screen.dart';
import '../../widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key, this.isLoading = true});
  final bool isLoading;

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
              leading: const Icon(Icons.menu),
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
            body: TabBarView(
              children: [
                HomeScreens(
                  isLoading: isLoading,
                ),
                const FeedSreen(),
                const ProfileScreen(),
                const SettingScreen(),
              ],
            ),
          )),
    );
  }
}
