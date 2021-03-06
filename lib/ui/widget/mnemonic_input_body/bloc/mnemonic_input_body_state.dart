import 'package:alan/alan.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

/// State of the "Import mnemonic" page.
///
/// If [mnemonicCheck] is provided, it represents the mnemonic phrase that must
/// be input by the user.
class MnemonicInputBodyState extends Equatable {
  final List<String>? mnemonicCheck;

  final bool creatingAddress;
  final Map<int, String> mnemonicWords;
  final int accountsNumber;

  /// Tells whether the page is loading or not
  final bool loading;

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

  /// Returns true iff the inserted mnemonic phrase has some errors or does not
  /// match the provided [mnemonicCheck].
  bool get hasError {
    if (mnemonicCheck != null) {
      var deepEq = const ListEquality().equals;
      return !deepEq(mnemonic, mnemonicCheck);
    }

    return !Bip39.validateMnemonic(mnemonic);
  }

  MnemonicInputBodyState({
    required this.mnemonicCheck,
    required this.mnemonicWords,
    required this.creatingAddress,
    required this.accountsNumber,
    required this.loading,
  });

  factory MnemonicInputBodyState.initial(List<String>? mnemonicCheck) {
    return MnemonicInputBodyState(
      mnemonicCheck: mnemonicCheck,
      mnemonicWords: {},
      creatingAddress: false,
      accountsNumber: 1,
      loading: false,
    );
  }

  MnemonicInputBodyState copy({
    Map<int, String>? mnemonicWords,
    bool? creatingAddress,
    int? accountsNumber,
    bool? loading,
  }) {
    return MnemonicInputBodyState(
      mnemonicCheck: mnemonicCheck,
      mnemonicWords: mnemonicWords ?? this.mnemonicWords,
      creatingAddress: creatingAddress ?? this.creatingAddress,
      accountsNumber: accountsNumber ?? this.accountsNumber,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [
        mnemonicCheck,
        mnemonicWords,
        creatingAddress,
        accountsNumber,
        loading,
      ];
}
