import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

/// Contains all the Desmos text styles used through all the application.
class DesmosTextStyles {
  static TextStyle title(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w500,
        );
  }

  static TextStyle thinHeader(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle largeBody(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle smallBody(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: DesmosColors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle thinBodyGrey(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: DesmosColors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle thinBodyBlack(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle boldBody(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        );
  }

  static TextStyle secondaryButton(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: DesmosColors.blue,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        );
  }

  static TextStyle error(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1.copyWith(
          color: Color(0xFFFF0404),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        );
  }
}
