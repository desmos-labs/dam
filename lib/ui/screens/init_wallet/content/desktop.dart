import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Content of the Home screen to be shown inside the web and dekstop
/// versions of the app.
class DesktopContent extends StatelessWidget {
  final void Function() navigateToImport;
  final void Function() navigateToGenerate;

  const DesktopContent({
    Key? key,
    required this.navigateToImport,
    required this.navigateToGenerate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/home-background-desktop.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/desmos-icon.png', width: 200),
            SizedBox(height: 30),
            Text(
              AppLocalizations.of(context)!.welcome,
              style: DesmosTextStyles.thinHeader(context),
            ),
            SizedBox(
              width: 325,
              child: Column(
                children: [
                  SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.networkTip,
                    textAlign: TextAlign.center,
                    style: DesmosTextStyles.thinSubHeader(context),
                  ),
                  SizedBox(height: 80),
                  LightButton(
                    text: AppLocalizations.of(context)!.generateAccount,
                    onPressed: navigateToGenerate,
                  ),
                  SizedBox(height: 16),
                  LightButton(
                    text: AppLocalizations.of(context)!.importMnemonic,
                    onPressed: navigateToImport,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
