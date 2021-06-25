import 'package:dam/ui/export.dart';
import 'package:dam/ui/screens/create_password/create_password_page.dart';
import 'package:dam/ui/screens/unlock_wallet/unlock_wallet_page.dart';
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
