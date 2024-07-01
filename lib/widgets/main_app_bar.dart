import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar(
      {super.key,
      this.showLeading = false,
      this.leading,
      this.centerTitle = true,
      required this.title,
      this.sizeLeading = 24,
      this.colorLeading = Colors.white,
      this.fontSize = 16,
      this.fontWeight = FontWeight.bold,
      this.action,
      this.flexiblaSpace,
      this.bottom,
      this.kToolbarHeight = 56});
  final bool showLeading;
  final Widget? leading;
  final double? sizeLeading;
  final Color? colorLeading;
  final String title;
  final bool centerTitle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final List<Widget>? action;
  final PreferredSizeWidget? bottom;
  final Widget? flexiblaSpace;
  final double kToolbarHeight;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      automaticallyImplyLeading: showLeading,
      leading: leading ??
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: sizeLeading,
                color: colorLeading,
              )),
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize, fontWeight: fontWeight),
      ),
      centerTitle: centerTitle,
      actions: action,
      bottom: bottom,
      flexibleSpace: flexiblaSpace,
    );
  }
}
