import 'package:flutter/material.dart';

class ShowInfoText extends StatelessWidget {
  const ShowInfoText(
      {super.key,
      this.mainAxisAlignment = MainAxisAlignment.center,
      required this.text,
      this.color = Colors.black,
      this.size = 16,
      this.fontWeight = FontWeight.normal});
  final MainAxisAlignment mainAxisAlignment;
  final String text;
  final Color color;
  final double size;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                  color: color, fontSize: size, fontWeight: fontWeight),
              overflow: TextOverflow.visible,
              softWrap: true,
            ),
          )
        ],
      ),
    );
  }
}
