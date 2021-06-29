import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String? labelText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;

  PasswordField({this.labelText, this.errorText, this.controller, this.onFieldSubmitted});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      obscureText: true,
      enabled: true,
      maxLines: 1,
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
    );
  }
}
