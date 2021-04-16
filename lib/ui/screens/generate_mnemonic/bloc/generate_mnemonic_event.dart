import 'package:equatable/equatable.dart';

/// Represents a generic event that is emitted for the generate account screen.
class GenerateMnemonicEvent extends Equatable {
  @override
  List<Object> get props => [];
}

/// Represents the event that is emitted when a new mnemonic should be generated
class GenerateNewMnemonic extends GenerateMnemonicEvent {}

/// Represents the event that is emitted when the user updates the value of
/// the checkbox that asks them to confirm they have written down the
/// mnemonic phrase
class UpdateMnemonicCheckboxValue extends GenerateMnemonicEvent {
  final bool value;

  UpdateMnemonicCheckboxValue(this.value);

  @override
  List<Object> get props => [value];
}
