import 'package:flutter/material.dart';

class ShowInfoButton extends StatelessWidget {
  const ShowInfoButton(
      {super.key,
      required this.text,
      required this.bgColor,
      this.frColor = Colors.white,
      this.size = 20,
      this.func,
      required this.icon});
  final Color bgColor;
  final Color frColor;
  final String text;
  final IconData icon;
  final double size;
  final VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: func,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            foregroundColor: frColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(
              text,
              style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
            )
          ],
        ));
  }
}
