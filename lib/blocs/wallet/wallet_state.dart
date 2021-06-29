import 'package:equatable/equatable.dart';

abstract class WalletState extends Equatable {
  const WalletState();
}

class WalletStateNotInitialized extends WalletState {
  const WalletStateNotInitialized();

  @override
  List<Object?> get props => [];
  
}

class WalletStateLocked extends WalletState {
  const WalletStateLocked();

  @override
  List<Object?> get props => [];

}

class WalletStateUnlocking extends WalletState {
  const WalletStateUnlocking();

  @override
  List<Object?> get props => [];

}

class WalletStateUnlocked extends WalletState {

  final List<String> mnemonic;

  WalletStateUnlocked(this.mnemonic);

  @override
  List<Object?> get props => [mnemonic];

}

enum WalletStateErrorKind {
  WrongPassword,
  Unknown,
}

class WalletStateError extends WalletState {

  final WalletStateErrorKind errorKind;
  final String? message;

  WalletStateError(this.errorKind, this.message);

  @override
  List<Object?> get props => [errorKind, message];

}