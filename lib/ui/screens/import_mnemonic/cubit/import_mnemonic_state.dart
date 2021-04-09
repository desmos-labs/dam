part of 'import_mnemonic_cubit.dart';

/// State of the "Import mnemonic" page.
class ImportMnemonicState extends Equatable {
  final bool creatingAddress;
  final Map<int, String> mnemonicWords;

  /// Returns the list of mnemonic words that have been entered till now.
  List<String> get mnemonic {
    if (mnemonicWords.isEmpty) {
      return List<String>.empty();
    }

    final words = List<String>.empty(growable: true);
    for (var i = 0; i < 24; i++) {
      final word = mnemonicWords[i + 1] ?? '';
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
    return has24Words && !Bip39.validateMnemonic(mnemonic);
  }

  ImportMnemonicState({
    required this.mnemonicWords,
    required this.creatingAddress,
  });

  factory ImportMnemonicState.initial() {
    return ImportMnemonicState(mnemonicWords: {}, creatingAddress: false);
  }

  ImportMnemonicState copy({
    Map<int, String>? mnemonicWords,
    bool? creatingAddress,
  }) {
    return ImportMnemonicState(
      mnemonicWords: mnemonicWords ?? this.mnemonicWords,
      creatingAddress: creatingAddress ?? this.creatingAddress,
    );
  }

  @override
  List<Object> get props => [mnemonicWords, creatingAddress];
}
