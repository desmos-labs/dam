import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Collects the most used routes of the application.
class DesmosRoutes {

  static void navigateToCreatePassword(
      BuildContext context,
      List<String> mnemonic,
      ) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return CreateWalletPasswordPage(
        mnemonic: mnemonic,
      );
    }));
  }

  static void navigateToUnlockWallet(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return UnlockWalletPage();
    }));
  }
}
