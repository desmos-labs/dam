import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dam/wallet/export.dart';

import 'generate_account_state.dart';
import 'generate_account_event.dart';

/// Represents the Bloc of the account generation page.
class GenerateAccountBloc
    extends Bloc<GenerateAccountEvent, GenerateAccountState> {
  GenerateAccountBloc() : super(GenerateAccountLoading());

  @override
  Stream<GenerateAccountState> mapEventToState(
    GenerateAccountEvent event,
  ) async* {
    if (event is GenerateAccounts) {
      _mapGenerateAccountsToState(event);
    }
  }

  void _mapGenerateAccountsToState(GenerateAccounts event) {
    final accountsNumber = event.accountsNumber;
    DesmosWallet.getAddresses(event.mnemonic, accountsNumber).then((value) {
      emit(GenerateAccountCompleted(value));
    });
  }
}
