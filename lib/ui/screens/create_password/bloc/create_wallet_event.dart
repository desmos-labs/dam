import 'package:equatable/equatable.dart';

abstract class CreateWalletEvent extends Equatable {
  const CreateWalletEvent();
}

class CreateNewWalletEvent extends CreateWalletEvent {
  final String mnemonic;
  final String password;

  CreateNewWalletEvent(this.mnemonic, this.password);

  @override
  List<Object?> get props => [mnemonic, password];
}
