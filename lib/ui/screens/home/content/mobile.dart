import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(height: 35),
                SvgPicture.asset('assets/desmos-icon.svg', width: 90),
                SizedBox(height: 19),
                Text(
                  AppLocalizations.of(context)!.welcome,
                  style: DesmosTextStyles.thinHeader(context),
                ),
              ],
            ),
            Column(
              children: [
                LightButton(
                  text: AppLocalizations.of(context)!.importMnemonic,
                  onPressed: navigateToImport,
                ),
                SizedBox(height: 16),
                LightButton(
                  text: AppLocalizations.of(context)!.generateAccount,
                  onPressed: navigateToGenerate,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
