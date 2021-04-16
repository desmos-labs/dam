import 'package:bloc/bloc.dart';
import 'package:dam/wallet/desmos_wallet.dart';

import 'generate_mnemonic_event.dart';
import 'generate_mnemonic_state.dart';

/// Cubit associated with the screen that allows the user to generate
/// a new account.
class GenerateMnemonicBloc
    extends Bloc<GenerateMnemonicEvent, GenerateMnemonicState> {
  GenerateMnemonicBloc() : super(GenerateMnemonicLoading());

  @override
  Stream<GenerateMnemonicState> mapEventToState(
      GenerateMnemonicEvent e) async* {
    if (e is GenerateNewMnemonic) {
      yield* _mapGenerateNewMnemonicEventToState();
    }
    if (e is UpdateMnemonicCheckboxValue) {
      yield* _mapChangeCheckBoxValue(e);
    }
  }

  /// Maps a GenerateNewMnemonicEvent and emits a series of new states
  Stream<GenerateMnemonicState> _mapGenerateNewMnemonicEventToState() async* {
    final currentState = state;
    if (currentState is GenerateMnemonicLoading) {
      yield* _generateAccount();
    } else if (currentState is GenerateMnemonicLoaded) {
      // Tell the UI we are loading
      yield currentState.copy(creatingAddress: true);
      yield* _generateAccount();
    }
  }

  /// Generates a new random mnemonic and emits the correct state
  Stream<GenerateMnemonicState> _generateAccount() async* {
    var termsAccepted = false;

    final currentState = state;
    if (currentState is GenerateMnemonicLoaded) {
      termsAccepted = currentState.termsAccepted;
    }

    final mnemonic = await DesmosWallet.generateMnemonic();
    yield GenerateMnemonicLoaded(
      creatingAddress: false,
      mnemonic: mnemonic,
      termsAccepted: termsAccepted,
    );
  }

  Stream<GenerateMnemonicState> _mapChangeCheckBoxValue(
    UpdateMnemonicCheckboxValue e,
  ) async* {
    final currentState = state;
    if (currentState is GenerateMnemonicLoaded) {
      yield currentState.copy(termsAccepted: e.value);
    }
  }
}
