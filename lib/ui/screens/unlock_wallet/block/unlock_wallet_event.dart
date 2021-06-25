import 'package:equatable/equatable.dart';

abstract class UnlockWalletEvent extends Equatable {
  const UnlockWalletEvent();
}

class UnlockWalletEventUnlock extends UnlockWalletEvent {

  final String password;

  UnlockWalletEventUnlock(this.password);

  @override
  List<Object?> get props => [password];
}