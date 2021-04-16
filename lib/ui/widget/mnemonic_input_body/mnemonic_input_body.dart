import 'package:dam/ui/widget/mnemonic_input_body/bloc/export.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import 'bloc/export.dart';
import 'mnemonic_phrase_input.dart';

/// Represents the widget that should be used inside a page that allows to
/// input a mnemonic phrase.
///
/// If provided, [texts] represent the widget that will be shown above the rest
/// of the mnemonic input body. This should be used to properly provide a page
/// title and body.
///
/// If provided, [mnemonicCheck] represents the mnemonic phrase that should be
/// input by the user. If the user does not insert this mnemonic correctly, the
/// next button will not unlock.
///
/// Requirement: it must be built inside a BlocProvider<MnemonicInputBodyBloc>
class MnemonicInputBody extends StatelessWidget {
  final Widget? texts;
  final List<String>? mnemonicCheck;

  final void Function(List<String> mnemonic, int accountsNumber) onNext;

  const MnemonicInputBody({
    Key? key,
    this.texts,
    this.mnemonicCheck,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MnemonicInputBodyBloc>(
      create: (context) => MnemonicInputBodyBloc(mnemonicCheck),
      child: Builder(
        builder: (context) {
          return ContentContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    texts ?? Container(),
                    _textBody(context),
                    _mnemonicPhraseInput(context),
                    _errorText(context),
                    _accountsNumber(context),
                  ],
                ),
                if (DesmosPlatform.isMobile(context)) SizedBox(height: 32),
                _testButton(context),
                _nextButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _textBody(BuildContext context) {
    return Text(
      AppLocalizations.of(context)!.importMnemonicBody,
      style: DesmosTextStyles.thinBodyGrey(context),
    );
  }

  Widget _mnemonicPhraseInput(BuildContext context) {
    return MnemonicPhraseInput(
      editable: true,
      onWordChanged: (index, word) => _onWordChanged(context, index, word),
    );
  }

  Widget _errorText(BuildContext context) {
    return BlocBuilder<MnemonicInputBodyBloc, MnemonicInputBodyState>(
      builder: (context, state) {
        if (!state.has24Words || !state.hasError) {
          return Container();
        }

        return Column(
          children: [
            SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)!.mnemonicNotValidError,
              style: DesmosTextStyles.error(context),
            ),
          ],
        );
      },
    );
  }

  Widget _accountsNumber(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32),
        Text(
          AppLocalizations.of(context)!.accountsToBeGeneratedText,
          style: DesmosTextStyles.thinBodyGrey(context),
        ),
        Container(
          width: 100,
          child: SpinBox(
            min: 1,
            value: 1,
            max: 5,
            decimals: 0,
            step: 1,
            enableInteractiveSelection: false,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: (value) => _onAccountsNumberChanged(context, value),
          ),
        ),
      ],
    );
  }

  Widget _testButton(BuildContext context) {
    if (!kDebugMode) {
      return Container();
    }

    return TextButton(
      onPressed: () {
        print("Using debug mnemonic");
        final bloc = BlocProvider.of<MnemonicInputBodyBloc>(context);
        final words = [
          "city",
          "find",
          "item",
          "chair",
          "deer",
          "hole",
          "tired",
          "swift",
          "tragic",
          "margin",
          "deliver",
          "evolve",
          "remind",
          "notable",
          "grocery",
          "cargo",
          "iron",
          "blast",
          "onion",
          "denial",
          "property",
          "april",
          "car",
          "shoot"
        ];
        words.asMap().forEach((index, element) {
          bloc.add(WordChanged(index + 1, element));
        });
      },
      child: Text('Use debug mnemonic'),
    );
  }

  Widget _nextButton(BuildContext context) {
    return BlocBuilder<MnemonicInputBodyBloc, MnemonicInputBodyState>(
      builder: (context, state) {
        final disableNext = !state.has24Words || state.hasError;
        return PrimaryButton(
          text: AppLocalizations.of(context)!.nextButtonText,
          onPressed: disableNext ? null : () => _onNext(context),
        );
      },
    );
  }

  void _onAccountsNumberChanged(BuildContext context, double value) {
    BlocProvider.of<MnemonicInputBodyBloc>(context)
        .add(ChangeAccountsNumber(value.toInt()));
  }

  /// Called when the word at the given index changes.
  void _onWordChanged(BuildContext context, int index, String word) {
    BlocProvider.of<MnemonicInputBodyBloc>(context)
        .add(WordChanged(index, word));
  }

  /// Called when the user presses the next button
  void _onNext(BuildContext context) {
    final state = BlocProvider.of<MnemonicInputBodyBloc>(context).state;
    onNext(state.mnemonic, state.accountsNumber);
  }
}
