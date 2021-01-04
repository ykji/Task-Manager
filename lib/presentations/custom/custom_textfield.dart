import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextStyle textStyle;
  final Function onChanged;
  final String labelText;
  final Widget icon;

  CustomTextField({
    this.controller,
    this.textStyle,
    this.onChanged,
    this.labelText,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: textStyle,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: textStyle,
        icon: icon,
      ),
    );
  }
}
