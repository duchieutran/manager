import 'package:flutter/material.dart';

class HomeTabbar extends StatelessWidget {
  const HomeTabbar(
      {super.key,
      required this.text,
      required this.icon,
      this.color = Colors.white});

  final String text;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Icon(
        icon,
        color: color,
      ),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
