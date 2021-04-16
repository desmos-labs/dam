import 'package:equatable/equatable.dart';

/// Represents a generic event for the account generation page.
abstract class GenerateAccountEvent extends Equatable {
  const GenerateAccountEvent();
}

/// Represents the event that is emitted when we want to generate the accounts.
class GenerateAccounts extends GenerateAccountEvent {
  final int accountsNumber;
  final List<String> mnemonic;

  GenerateAccounts(this.accountsNumber, this.mnemonic);

  @override
  List<Object?> get props => [accountsNumber, mnemonic];
}
