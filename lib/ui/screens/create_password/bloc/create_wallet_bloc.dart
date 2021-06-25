import 'package:dam/sources/wallet/wallet_source.dart';
import 'package:dam/ui/screens/create_password/bloc/create_wallet_event.dart';
import 'package:dam/ui/screens/create_password/bloc/create_wallet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kiwi/kiwi.dart';

class CreateWalletBloc extends Bloc<CreateWalletEvent, CreateWalletState?> {

  CreateWalletBloc() : super(null);

  @override
  Stream<CreateWalletState?> mapEventToState(CreateWalletEvent event) async* {
    if (event is CreateNewWalletEvent) {
      _mapCreateNewWalletEventToState(event);
    }
  }

  void _mapCreateNewWalletEventToState(CreateNewWalletEvent event) {
    emit(CreateWalletCreating());
    var walletSource = KiwiContainer().resolve<WalletSource>();
    walletSource.initEmpty(event.password);
    walletSource.storeMnemonic(event.mnemonic);
    walletSource.lock();
    emit(CreateWalletCreated());
  }

}