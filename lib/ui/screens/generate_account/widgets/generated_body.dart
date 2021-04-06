import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'reload_button.dart';

/// Body of the generate account screen shown to the user when a random
/// mnemonic has been generated properly.
class GeneratedAccountBody extends StatelessWidget {
  final List<String> words;

  final void Function() onRandomPressed;
  final void Function() onGenerateAccountPressed;

  const GeneratedAccountBody({
    Key key,
    @required this.words,
    @required this.onRandomPressed,
    @required this.onGenerateAccountPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Flexible(child: MnemonicInput(words: words)),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ReloadButton(onPressed: onRandomPressed),
                  ],
                ),
              ],
            ),
          ),
          PrimaryButton(
            text: AppLocalizations.of(context).generateAccount,
            onPressed: onGenerateAccountPressed,
          ),
        ],
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
}
