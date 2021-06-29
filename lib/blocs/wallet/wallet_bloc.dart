import 'package:dam/blocs/wallet/wallet_event.dart';
import 'package:dam/blocs/wallet/wallet_state.dart';
import 'package:dam/sources/secure/secure_source.dart';
import 'package:dam/sources/wallet/wallet_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  
  WalletBloc(WalletState initialState) : super(initialState);
  
  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    var walletSource = KiwiContainer().resolve<WalletSource>();
    if (event is WalletEventCreate) {
      walletSource.initEmpty(event.password);
      walletSource.storeMnemonic(event.mnemonic.join(' '));
      walletSource.lock();
      emit(WalletStateLocked());
    } else if (event is WalletEventUnlock) {
      try {
        emit(WalletStateUnlocking());
        walletSource.unlock(event.password);
        var mnemonic = walletSource.getMnemonic();
        if (mnemonic != null) {
          emit(WalletStateUnlocked(mnemonic.split(' ')));
        }
        else {
          emit(WalletStateError(WalletStateErrorKind.Unknown, 'wallet corrupted'));
        }
      } on SecureSourceInvalidPassword {
        emit(WalletStateError(WalletStateErrorKind.WrongPassword, 'invalid password'));
      } on SecureSourceException catch (ex) {
        emit(WalletStateError(WalletStateErrorKind.Unknown, ex.message));
      }
    } else if (event is WalletEventLock) {
      walletSource.lock();
      emit(WalletStateLocked());
    }
    else {
      emit(WalletStateError(WalletStateErrorKind.Unknown, 'unknown event detected'));
    }
  }


  @override
  void onEvent(WalletEvent event) {
    print(event);
    super.onEvent(event);
  }

  static WalletBloc newInstance() {
    var walletSource = KiwiContainer().resolve<WalletSource>();
    if (!walletSource.isInitialized()) {
      return WalletBloc(WalletStateNotInitialized());
    }
    else if(walletSource.isLocked()) {
      return WalletBloc(WalletStateLocked());
    }

    var mnemonic = walletSource.getMnemonic()!;
    return WalletBloc(WalletStateUnlocked(mnemonic.split(' ')));
  }
  
}