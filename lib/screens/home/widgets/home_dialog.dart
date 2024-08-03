import 'package:flutter/cupertino.dart';

class ShowCustomDialog extends StatefulWidget {
  final String title;
  final String content;
  final List<Widget>? action;
  const ShowCustomDialog(
      {super.key, required this.title, required this.content, this.action});

  @override
  State<ShowCustomDialog> createState() => _ShowCustomDialogState();
}

class _ShowCustomDialogState extends State<ShowCustomDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(widget.title),
      content: Text(widget.content),
      actions: widget.action ??
          [
            CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
    );
  }
}
