import 'package:appdemo/screens/login/login_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
