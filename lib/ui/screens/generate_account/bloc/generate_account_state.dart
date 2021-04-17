import 'package:equatable/equatable.dart';

/// Represents a generic state for the account generation page.
abstract class GenerateAccountState extends Equatable {
  const GenerateAccountState();
}

/// Represents the state of the account generation page while the accounts are
/// being generated.
class GenerateAccountLoading extends GenerateAccountState {
  @override
  List<Object> get props => [];
}

/// Represents the state of the account generation page when the accounts
/// are generated successfully.
class GenerateAccountCompleted extends GenerateAccountState {
  final List<String> addresses;

  GenerateAccountCompleted(this.addresses);

  @override
  List<Object> get props => [addresses];
}
