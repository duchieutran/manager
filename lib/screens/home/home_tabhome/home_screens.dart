import 'dart:convert';

import 'package:appdemo/global/app_router.dart';
import 'package:appdemo/models/model_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  List<ModelUser> users = [];

  @override
  void initState() {
    fetchAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            onTap: () => Navigator.of(context)
                .pushNamed(AppRouter.showinfo, arguments: user),
            leading: ClipOval(
              child: Image(
                image: NetworkImage(user.image),
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),
            ),
            title: Text(user.name),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }

  fetchAPI() async {
    final response = await rootBundle.loadString('assets/json/user_data.json');
    final List data = await json.decode(response);
    setState(() {
      users = data.map((e) => ModelUser.fromJSON(e)).toList();
    });
  }
}
