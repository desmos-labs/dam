import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'reload_button.dart';

/// This page is shown to the user when they navigate here from the main screen.
/// It is used to generate a new Desmos account data and let them copy the
/// output values (address, mnemonic, etc).
class GenerateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context).generateAccountPageTitle,
                          style: DesmosTextStyles.title(context),
                        ),
                        SizedBox(height: 8),
                        Text(
                          AppLocalizations.of(context).writeSaveMnemonic,
                          style: DesmosTextStyles.thinBodyGrey(context),
                        ),
                        getBodyText(context),
                      ],
                    ),
                    Flexible(child: MnemonicInput(
                      words: List.generate(24, (index) => "test")
                    )),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ReloadButton(onPressed: () => _onRandomPressed),
                      ],
                    ),
                  ],
                ),
              ),
              PrimaryButton(
                text: AppLocalizations.of(context).generateAccount,
                onPressed: () => _onGenerateAccountPressed(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the body text that tells the user that using the mnemonic phrase
  /// is the only way to restore the account.
  /// We do this because the line contains a bold part, which must be handled
  /// as a separate [TextSpan].
  Widget getBodyText(BuildContext context) {
    final bodyText = AppLocalizations.of(context).onlyWayRestore;
    final onlyWay = AppLocalizations.of(context).onlyWay.toUpperCase();

    final parts = bodyText.split("%s").map((text) {
      return TextSpan(
        text: text,
        style: DesmosTextStyles.thinBodyGrey(context),
      );
    }).toList();

    return RichText(
      text: TextSpan(children: [
        parts[0],
        TextSpan(text: onlyWay, style: DesmosTextStyles.boldBody(context)),
        parts[1],
      ]),
    );
  }

  void _onRandomPressed() {
    // TODO
  }

  /// Method called when the user presses the "Generate account" button.
  void _onGenerateAccountPressed(BuildContext context) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return AccountGeneratedPage(address: 'desmos1ep43snea3f9y76hnaz3n89n7kcg6fuvumhr4af');
    }));
  }
}
