import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Home content for the mobile devices.
class MobileContent extends StatelessWidget {
  final void Function() navigateToImport;
  final void Function() navigateToGenerate;

  const MobileContent({
    Key? key,
    required this.navigateToImport,
    required this.navigateToGenerate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/home-background-mobile.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 35),
                    Image.asset('assets/desmos-icon.png', width: 90),
                    SizedBox(height: 19),
                    Text(
                      AppLocalizations.of(context)!.welcome,
                      style: DesmosTextStyles.thinHeader(context),
                    ),
                    SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.networkTip,
                      style: DesmosTextStyles.thinSubHeader(context),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
