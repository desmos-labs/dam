import 'package:alan/alan.dart';
import 'package:bloc/bloc.dart';
import 'package:dam/ui/export.dart';
import 'package:equatable/equatable.dart';
import 'package:dam/wallet/export.dart';
import 'package:flutter/cupertino.dart';

part 'import_mnemonic_state.dart';

/// Cubit of the "Import mnemonic" page.
class ImportMnemonicCubit extends Cubit<ImportMnemonicState> {
  ImportMnemonicCubit() : super(ImportMnemonicState.initial());

  void updateWord(int index, String word) {
    final currentState = state;
    if (currentState is ImportMnemonicState) {
      final words = Map<int, String>.from(currentState.mnemonicWords);
      words[index] = word;
      emit(ImportMnemonicState(mnemonicWords: words, creatingAddress: false));
    }
  }

  void generateAddress(BuildContext context) {
    emit(state.copy(creatingAddress: true));
    DesmosWallet.getAddress(state.mnemonic).then((address) {
      if (address == null) return;
      DesmosRoutes.navigateToGeneratedAddress(context, address);
    });
  }
}
