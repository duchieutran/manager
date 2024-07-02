import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText(
      {super.key,
      required this.text,
      this.color = Colors.black,
      this.size = 16,
      this.fontWeight = FontWeight.normal,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.horizontal = 8,
      this.vertical = 15});

  final String text;
  final Color? color;
  final double? size;
  final FontWeight? fontWeight;
  final MainAxisAlignment mainAxisAlignment;
  final double horizontal;
  final double vertical;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: Text(
            text,
            style: TextStyle(
                color: color,
                fontSize: size,
                fontWeight: fontWeight,
                decoration: TextDecoration.none),
          ),
        )
      ],
    );
  }
}
