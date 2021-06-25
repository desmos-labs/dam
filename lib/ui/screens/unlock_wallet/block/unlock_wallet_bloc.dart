import 'package:dam/sources/secure/secure_source.dart';
import 'package:dam/sources/wallet/wallet_source.dart';
import 'package:dam/ui/screens/unlock_wallet/block/unlock_wallet_event.dart';
import 'package:dam/ui/screens/unlock_wallet/block/wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class UnlockWalletBloc extends Bloc<UnlockWalletEvent, WalletState> {

  UnlockWalletBloc() : super(WalletStateLocked());

  @override
  Stream<WalletState> mapEventToState(UnlockWalletEvent event) async* {
      if (event is UnlockWalletEventUnlock) {
        _mapUnlockNewWalletEventToState(event);
      }
  }

  void _mapUnlockNewWalletEventToState(UnlockWalletEventUnlock event) {
    emit(WalletStateUnlocking());

    try {
      var walletSource = KiwiContainer().resolve<WalletSource>();
      walletSource.unlock(event.password);

      final mnemonic = walletSource.getMnemonic();
      walletSource.lock();

      if (mnemonic != null) {
        emit(WalletStateUnlocked(mnemonic));
      }
    } on SecureSourceInvalidPassword {
      emit(WalletStateError(WalletStateErrorKind.WrongPassword, null));
    } on SecureSourceException catch(e) {
      emit(WalletStateError(WalletStateErrorKind.Unknown, e.message));
    }
  }

}