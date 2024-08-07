import 'package:appdemo/provider/connect_provider.dart';
import 'package:provider/provider.dart';
import '../../global/app_router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: AppRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Consumer<NetworkStatus>(
          builder: (context, networkStatus, child) {
            return Stack(
              children: [
                const Navigator(
                  onGenerateRoute: AppRouter.onGenerateRoute,
                ),
                if (networkStatus == NetworkStatus.offline)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.red,
                      padding: const EdgeInsets.all(8.0),
                      child: const Text(
                        'No Internet Connection',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
