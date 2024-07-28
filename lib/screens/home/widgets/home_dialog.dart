import 'package:flutter/cupertino.dart';

class ShowCustomDialog extends StatefulWidget {
  final String title;
  final String content;
  final VoidCallback? action;
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
      actions: [
        CupertinoDialogAction(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
              if (widget.action != null) widget.action!();
            })
      ],
    );
  }
}
