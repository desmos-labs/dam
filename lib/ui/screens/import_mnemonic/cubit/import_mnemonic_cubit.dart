import 'package:alan/alan.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dam/wallet/export.dart';

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

  String? getAddress() {
    emit(state.copy(creatingAddress: true));
    final address = DesmosWallet.getAddress(state.mnemonic);
    emit(state.copy(creatingAddress: false));
    return address;
  }
}
