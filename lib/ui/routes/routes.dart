import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Collects the most used routes of the application.
class DesmosRoutes {
  /// Navigates to the generated address screen to display the given [address].
  static void navigateToGeneratedAddress(BuildContext context, String address) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return AccountGeneratedPage(address: address);
    }));
  }
}
