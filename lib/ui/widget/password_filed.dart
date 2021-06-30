import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String? labelText;
  final String? errorText;
  final TextEditingController? controller;
  final ValueChanged<String>? onFieldSubmitted;
  final FormFieldValidator<String>? validator;

  PasswordField(
      {this.labelText,
      this.errorText,
      this.controller,
      this.onFieldSubmitted,
      this.validator});

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
      validator: validator,
    );
  }
}
