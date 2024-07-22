import 'package:flutter/cupertino.dart';

class HomeTabhomeDialog {
  static void showCustomDialog({
    required BuildContext context,
    required String title,
    required String content,
    VoidCallback? action,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                if (action != null) action();
              },
            ),
          ],
        );
      },
    );
  }
}
