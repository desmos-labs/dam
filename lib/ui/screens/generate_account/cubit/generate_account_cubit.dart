import 'package:alan/alan.dart';
import 'package:bloc/bloc.dart';
import 'package:dam/wallet/desmos_wallet.dart';
import 'package:equatable/equatable.dart';

part 'generate_account_state.dart';

/// Cubit associated with the screen that allows the user to generate
/// a new account.
class GenerateAccountCubit extends Cubit<GenerateAccountState> {
  GenerateAccountCubit() : super(GenerateAccountLoading());

  void random() {
    final mnemonic = Bip39.generateMnemonic(strength: 256);
    emit(GenerateAccountLoaded(mnemonic: mnemonic));
  }

  String? getAddress() {
    final currentState = state;
    if (currentState is GenerateAccountLoaded) {
      return DesmosWallet.getAddress(currentState.mnemonic);
    }

    return null;
  }
}
