import 'package:flutter/material.dart';

class DesmosColors {
  static const MaterialColor orange = MaterialColor(
    _desmosPrimaryValue,
    <int, Color>{
      50: Color(0xFFfdedea),
      100: Color(0xFFfad3cb),
      200: Color(0xFFf6b6a9),
      300: Color(0xFFf29887),
      400: Color(0xFFf0826d),
      500: Color(_desmosPrimaryValue),
      600: Color(0xFFeb644c),
      700: Color(0xFFe85942),
      800: Color(0xFFe54f39),
      900: Color(0xFFe03d29),
    },
  );

  static const int _desmosPrimaryValue = 0xFFED6C53;

  static Color grey = Color(0xFF646464);
  static Color blue = Color(0xFF326CDE);
}
