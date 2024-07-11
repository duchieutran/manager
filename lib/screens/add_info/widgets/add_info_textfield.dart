import 'package:flutter/material.dart';

class EditTextfield extends StatelessWidget {
  const EditTextfield({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.icon,
    required this.textInputType,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final Widget? icon;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        decoration: InputDecoration(
          label: Text(
            title,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w400,
            ),
          ),
          hintText: hintText,
          prefixIcon: icon,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    );
  }
}
