import 'package:appdemo/provider/add_provider.dart';
import 'package:appdemo/provider/connect_provider.dart';
import 'package:appdemo/provider/edit_provider.dart';
import 'package:provider/provider.dart';
import 'screens/app/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => EditProvider()),
      ChangeNotifierProvider(create: (context) => AddProvider()),
      StreamProvider(
          create: (context) => ConnectProvider().controller.stream,
          initialData: NetworkStatus.online)
    ],
    child: const MyApp(),
  ));
}
