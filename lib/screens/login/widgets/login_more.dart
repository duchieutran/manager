import 'package:flutter/material.dart';

class LoginMore extends StatelessWidget {
  const LoginMore({super.key, required this.logo, this.function});
  final String logo;
  final Function? function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GestureDetector(
        onTap: () {
          function;
        },
        child: ClipOval(
          child: SizedBox(
            width: 30,
            height: 30,
            child: Image(fit: BoxFit.cover, image: AssetImage(logo)),
          ),
        ),
      ),
    );
  }
}
