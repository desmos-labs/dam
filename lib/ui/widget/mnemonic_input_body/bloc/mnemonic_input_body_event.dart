import 'package:equatable/equatable.dart';

/// Represents a generic event that is emitted from within
/// the MnemonicInputBodyBloc widget
class MnemonicInputBodyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Represents the event that is emitted when a word at a specific
/// index changes.
class WordChanged extends MnemonicInputBodyEvent {
  final int index;
  final String word;

  WordChanged(this.index, this.word);

  @override
  List<Object?> get props => [index, word];
}

/// Event that is emitted when the number of accounts to generate changes.
class ChangeAccountsNumber extends MnemonicInputBodyEvent {
  final int number;

  ChangeAccountsNumber(this.number);

  @override
  List<Object?> get props => [number];
}

/// Represents the event that is emitted when we should start visualizing the
/// loading bar.
class ShowsLoadingBar extends MnemonicInputBodyEvent {}
