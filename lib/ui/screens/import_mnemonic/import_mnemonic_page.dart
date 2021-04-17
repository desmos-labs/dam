import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

/// Page that is shown to the user when they want to import an already existing
/// mnemonic phrase. It allows to insert the 24 words and then generate the
/// account from those.
class ImportMnemonicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: MnemonicInputBody(
          texts: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.importMnemonicPageTitle,
                style: DesmosTextStyles.title(context),
              ),
              SizedBox(height: 8),
            ],
          ),
          onNext: (words, accountsNumber) {
            _onNext(context, words, accountsNumber);
          },
        ),
      ),
    );
  }

  /// Called when the user presses the "Next" button.
  void _onNext(BuildContext context, List<String> words, int accountsNumber) {
    DesmosRoutes.navigateToGeneratedAddress(context, accountsNumber, words);
  }
}
