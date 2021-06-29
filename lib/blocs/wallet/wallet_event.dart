import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
}

class WalletEventCreate extends WalletEvent {

  final String password;
  final List<String> mnemonic;

  WalletEventCreate(this.password, this.mnemonic);

  @override
  List<Object?> get props => [password, mnemonic];
}

class WalletEventLock extends WalletEvent {

  const WalletEventLock();

  @override
  List<Object?> get props => [];
}

class WalletEventUnlock extends WalletEvent {

  final String password;

  WalletEventUnlock(this.password);

  @override
  List<Object?> get props => [password];
}