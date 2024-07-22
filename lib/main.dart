import 'package:appdemo/screens/home/home_tabhome/widgets/home_tabhome_provider.dart';
import 'package:provider/provider.dart';
import 'screens/app/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HomeTabhomeProvider(),
      )
    ],
    child: const MyApp(),
  ));
}
