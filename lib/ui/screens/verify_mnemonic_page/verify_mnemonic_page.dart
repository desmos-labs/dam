import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Page that requires the user to insert the given [mnemonic] to make sure
/// they have written it down on a piece of paper.
class VerifyMnemonicPage extends StatelessWidget {
  final List<String> mnemonic;

  const VerifyMnemonicPage({
    Key? key,
    required this.mnemonic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            MnemonicInputBody(
              mnemonicCheck: mnemonic,
              texts: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.verifyMnemonicPageTitle,
                    style: DesmosTextStyles.title(context),
                  ),
                  SizedBox(height: 8),
                  Text(
                    AppLocalizations.of(context)!.verifyMnemonicPageBody,
                    style: DesmosTextStyles.thinBodyGrey(context),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              onNext: (words, accountsNumber) {
                _onNext(context, words, accountsNumber);
              },
            )
            // LoadingBar(),
          ],
        ),
      ),
    );
  }

  /// Called when the user presses the "Next" button.
  void _onNext(BuildContext context, List<String> words, int accountsNumber) {
    DesmosRoutes.navigateToCreatePassword(context, words);
  }
}
