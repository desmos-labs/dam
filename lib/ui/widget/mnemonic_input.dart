import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

/// Represents the overall mnemonic input that allows the user to insert a 24
/// words seed phrase.
class MnemonicInput extends StatelessWidget {
  final List<String> words;

  const MnemonicInput({
    Key key,
    this.words = const [],
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
        return MnemonicWord(
          index: index + 1,
          editable: words.isEmpty,
          word: words.isEmpty ? null : words[index],
        );
      }),
    );
  }
}
