import 'package:appdemo/provider/connect_provider.dart';
import 'package:provider/provider.dart';
import 'home_tabfeed/home_tabfeed.dart';
import 'widgets/home_tabbar.dart';
import 'home_tabhome/home_tabhome.dart';
import 'home_tabprofile/home_tabprofile.dart';
import 'home_tabsetting/home_tabsetting.dart';
import '../../widgets/main_app_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final provider = Provider.of<ConnectProvider>(context);
    provider.addListener(_checkConnect);
  }

  @override
  void dispose() {
    final provider = Provider.of<ConnectProvider>(context, listen: false);
    provider.removeListener(_checkConnect);
    super.dispose();
  }

  // void _showConnectivityDialog() {
  //   _checkConnect(connectivityResult);
  // }

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

  void _checkConnect() {
    final connectivityResult = context.read<ConnectProvider>().messConnect;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(connectivityResult),
    ));
  }
}
