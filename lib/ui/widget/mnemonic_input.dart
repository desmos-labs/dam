import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

/// Represents the overall mnemonic input that allows the user to insert a 24
/// words seed phrase.
class MnemonicInput extends StatelessWidget {
  final bool editable;
  final List<String> words;
  final void Function(int index, String word) onWordChanged;

  const MnemonicInput({
    Key key,
    this.editable = false,
    this.words = const [],
    this.onWordChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 3,
      shrinkWrap: true,
      primary: false,
      children: List.generate(24, (index) {
        return MnemonicWordInput(
          index: index + 1,
          editable: editable,
          onWordChanged: onWordChanged,
          word: words.isEmpty ? null : words[index],
        );
      }),
    );
  }
}
