import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final String? _labelText;
  final String? _errorText;
  final TextEditingController? _controller;

  PasswordField(this._labelText, this._errorText, this._controller);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: _labelText,
          errorText: _errorText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      obscureText: true,
      enabled: true,
      maxLines: 1,
      controller: _controller,
    );
  }
}
