import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:flutter/foundation.dart';

part 'import_mnemonic_state.dart';

/// Cubit of the "Import mnemonic" page.
class ImportMnemonicCubit extends Cubit<ImportMnemonicState> {
  ImportMnemonicCubit() : super(ImportMnemonicState.initial());

  void updateWord(int index, String word) {
    final currentState = state;
    if (currentState is ImportMnemonicState) {
      final words = Map<int, String>  .from(currentState.mnemonicWords);
      words[index] = word;
      emit(ImportMnemonicState(mnemonic: words));
    }
  }
}
