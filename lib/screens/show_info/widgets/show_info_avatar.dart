import 'package:appdemo/global/img_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ShowInfoAvatar extends StatelessWidget {
  const ShowInfoAvatar({super.key, required this.image, required this.check});
  final String image;
  final bool check;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.all(10),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            border: Border.all(
                color: const Color.fromARGB(255, 240, 161, 239), width: 8)),
        child: CircleAvatar(
          backgroundImage: check
              ? AssetImage(ImgPath().logoGit)
              : NetworkImage(image) as ImageProvider,
          radius: 25,
        ),
      ),
    );
  }
}
