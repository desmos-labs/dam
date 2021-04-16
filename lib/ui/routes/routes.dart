import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Collects the most used routes of the application.
class DesmosRoutes {
  /// Navigates to the address generation screen.
  static void navigateToGeneratedAddress(
    BuildContext context,
    int accountsToGenerate,
    List<String> mnemonic,
  ) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return GenerateAccountPage(
        accountsNumber: accountsToGenerate,
        mnemonic: mnemonic,
      );
    }));
  }
}
