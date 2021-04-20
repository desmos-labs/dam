import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/export.dart';
import 'reload_button.dart';

/// Body of the generate account screen shown to the user when a random
/// mnemonic has been generated properly.
class GeneratedAccountBody extends StatelessWidget {
  final List<String> words;
  final void Function(List<String> mnemonic) onNext;

  const GeneratedAccountBody({
    Key? key,
    required this.words,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final texts = [
      Text(
        AppLocalizations.of(context)!.writeSaveMnemonic,
        style: DesmosTextStyles.warningBody(context),
      ),
      getBodyText(context),
      Text(
        AppLocalizations.of(context)!.mnemonicTip,
        style: DesmosTextStyles.thinBodyGrey(context),
      ),
      Text(
        AppLocalizations.of(context)!.mnemonicWarningNextPage,
        style: DesmosTextStyles.thinBodyGrey(context),
      )
    ];

    return ContentContainer(
      child: ListView(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.generateAccountPageTitle,
                style: DesmosTextStyles.title(context),
              ),
              SizedBox(height: 16),
              DesmosPlatform.isMobile(context)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: texts,
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          texts[0],
                          SizedBox(width: 4),
                          texts[1],
                        ]),
                        ...texts.getRange(2, texts.length),
                      ],
                    ),
              SizedBox(height: 16),
              MnemonicPhraseInput(words: words),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ReloadButton(onPressed: () => _getRandomMnemonic(context)),
              ]),
            ],
          ),
          SizedBox(height: DesmosPlatform.isMobile(context) ? 32 : 16),
          confirmWriteDownCheckBox(context),
          BlocBuilder<GenerateMnemonicBloc, GenerateMnemonicState>(
            builder: (context, currentState) {
              var enabled = false;

              final state = currentState;
              if (state is GenerateMnemonicLoaded) {
                enabled = state.termsAccepted;
              }

              return PrimaryButton(
                text: AppLocalizations.of(context)!.nextButtonText,
                onPressed: enabled ? () => _onNext(context) : null,
              );
            },
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
    final bodyText = AppLocalizations.of(context)!.onlyWayRestore;
    final onlyWay = AppLocalizations.of(context)!.onlyWay.toUpperCase();

    final parts = bodyText.split('%s').map((text) {
      return TextSpan(
        text: text,
        style: DesmosTextStyles.warningBody(context),
      );
    }).toList();

    return RichText(
      text: TextSpan(children: [
        parts[0],
        TextSpan(text: onlyWay, style: DesmosTextStyles.warningBody(context)),
        parts[1],
      ]),
    );
  }

  /// Returns the checkbox used to confirm that the user has written down the
  /// mnemonic phrase on a piece of paper.
  Widget confirmWriteDownCheckBox(BuildContext context) {
    return BlocBuilder<GenerateMnemonicBloc, GenerateMnemonicState>(
        builder: (context, state) {
      if (state is GenerateMnemonicLoading) {
        return Container();
      }

      final currentState = state as GenerateMnemonicLoaded;
      return Row(
        children: [
          Checkbox(
            value: currentState.termsAccepted,
            onChanged: (value) => _updateCheckBoxValue(context),
          ),
          Expanded(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => _updateCheckBoxValue(context),
                child: Text(
                  AppLocalizations.of(context)!.iHaveWrittenTheWords,
                  style: DesmosTextStyles.warningBody(context),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  void _getRandomMnemonic(BuildContext context) {
    BlocProvider.of<GenerateMnemonicBloc>(context).add(GenerateNewMnemonic());
  }

  /// Called each time that the checkbox value is updated
  void _updateCheckBoxValue(BuildContext context) {
    BlocProvider.of<GenerateMnemonicBloc>(context)
        .add(UpdateMnemonicCheckboxValue());
  }

  /// Called when the user presses the "Next" button
  void _onNext(BuildContext context) {
    final currentState = BlocProvider.of<GenerateMnemonicBloc>(context).state;
    if (currentState is GenerateMnemonicLoaded) {
      onNext(currentState.mnemonic);
    }
  }
}
