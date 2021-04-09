import 'package:flutter/material.dart';

class DesmosColors {
  // TODO: Change other colors
  static const MaterialColor orange = MaterialColor(
    _desmosPrimaryValue,
    <int, Color>{
      50: Color(0xFFFCE4EC),
      100: Color(0xFFF8BBD0),
      200: Color(0xFFF48FB1),
      300: Color(0xFFF06292),
      400: Color(0xFFEC407A),
      500: Color(_desmosPrimaryValue),
      600: Color(0xFFD81B60),
      700: Color(0xFFC2185B),
      800: Color(0xFFAD1457),
      900: Color(0xFF880E4F),
    },
  );

  static const int _desmosPrimaryValue = 0xFFED6C53;

  static Color grey = Color(0xFF646464);
  static Color blue = Color(0xFF326CDE);
}
