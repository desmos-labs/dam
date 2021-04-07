part of 'generate_account_cubit.dart';

abstract class GenerateAccountState extends Equatable {
  const GenerateAccountState();
}

/// State that is used to indicate the page is still loading.
class GenerateAccountLoading extends GenerateAccountState {
  @override
  List<Object> get props => [];
}

/// State that is used to represent the fact that the mnemonic phrase has been
/// loaded properly and should be visualized by the user.
class GenerateAccountLoaded extends GenerateAccountState {
  final List<String> mnemonic;

  GenerateAccountLoaded({required List<String> mnemonic})
      : assert(mnemonic.isNotEmpty),
        mnemonic = mnemonic;

  @override
  List<Object> get props => [mnemonic];
}
