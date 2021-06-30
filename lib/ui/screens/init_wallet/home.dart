import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

import 'content/export.dart';

/// This widget represents the home page of the application, which is the
/// main screen that is shown to the user when they open the app.
class InitWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DesmosPlatform.isMobile(context)
          ? MobileContent(
              navigateToGenerate: () => _navigateToGenerator(context),
              navigateToImport: () => _navigateToImportMnemonic(context),
            )
          : DesktopContent(
              navigateToImport: () => _navigateToImportMnemonic(context),
              navigateToGenerate: () => _navigateToGenerator(context),
            ),
    );
  }

  void _navigateToGenerator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GenerateMnemonicPage();
    }));
  }

  void _navigateToImportMnemonic(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImportMnemonicPage();
    }));
  }
}
