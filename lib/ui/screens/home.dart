import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget represents the home page of the application, which is the
/// main screen that is shown to the user when they open the app.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/home-background-mobile.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(height: 35),
                  Image.asset('assets/desmos-icon.png', width: 68),
                  SizedBox(height: 19),
                  Text(
                    AppLocalizations.of(context).welcome,
                    style: DesmosTextStyles.thinHeader(context),
                  ),
                ],
              ),
              Column(
                children: [
                  LightButton(
                    text: AppLocalizations.of(context).importMnemonic,
                    onPressed: () => _navigateToImportMnemonic(context),
                  ),
                  SizedBox(height: 16),
                  LightButton(
                    text: AppLocalizations.of(context).generateAccount,
                    onPressed: () => _navigateToGenerator(context),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToGenerator(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GenerateAccountPage();
    }));
  }

  void _navigateToImportMnemonic(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ImportMnemonicPhrasePage();
    }));
  }
}
