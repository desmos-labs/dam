part of 'import_mnemonic_cubit.dart';

/// State of the "Import mnemonic" page.
class ImportMnemonicState extends Equatable {
  final Map<int, String> mnemonicWords;

  /// Returns the list of mnemonic words that have been entered till now.
  List<String> get mnemonic {
    if (mnemonicWords.isEmpty) {
      return List<String>.empty();
    }

    final words = List<String>.empty(growable: true);
    for (int i = 0; i < 24; i++) {
      final word = mnemonicWords[i + 1] ?? "";
      words.add(word);
    }
    return words;
  }

  /// Tells whether the mnemonic has been all input or not.
  bool get has24Words {
    return mnemonic.where((element) => element.isNotEmpty).length == 24;
  }

  /// Returns true iff the inserted mnemonic phrase has some errors.
  bool get hasError {
    return has24Words && !bip39.validateMnemonic(this.mnemonic.join(" "));
  }

  ImportMnemonicState({
    @required Map<int, String> mnemonic,
  })  : assert(mnemonic != null),
        this.mnemonicWords = mnemonic;

  factory ImportMnemonicState.initial() {
    return ImportMnemonicState(mnemonic: Map());
  }

  @override
  List<Object> get props => [mnemonicWords];
}
