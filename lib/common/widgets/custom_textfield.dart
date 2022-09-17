import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintLabel;
  final int maxLines;
  const CustomTextField(
      {Key? key,
      required this.hintLabel,
      required this.controller,
      this.maxLines = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintLabel,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black38))),
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Enter your $hintLabel";
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
