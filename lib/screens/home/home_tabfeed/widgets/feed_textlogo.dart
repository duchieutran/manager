import 'package:flutter/material.dart';

class FeedTextlogo {
  TextSpan textLogo({required String text, required Color color}) {
    return TextSpan(
        text: text,
        style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontStyle: FontStyle.italic));
  }
}
