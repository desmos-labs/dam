import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:bip39/bip39.dart' as bip39;

part 'generate_account_state.dart';

/// Cubit associated with the screen that allows the user to generate
/// a new account.
class GenerateAccountCubit extends Cubit<GenerateAccountState> {
  GenerateAccountCubit() : super(GenerateAccountLoading());

  void random() {
    final mnemonic = bip39.generateMnemonic(strength: 256);
    final mnemonicWords = mnemonic.split(" ");
    emit(GenerateAccountLoaded(mnemonic: mnemonicWords));
  }
}
