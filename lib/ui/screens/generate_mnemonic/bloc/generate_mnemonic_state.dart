import 'package:equatable/equatable.dart';

abstract class GenerateMnemonicState extends Equatable {
  const GenerateMnemonicState();
}

/// State that is used to indicate the page is still loading.
class GenerateMnemonicLoading extends GenerateMnemonicState {
  @override
  List<Object> get props => [];
}

/// State that is used to represent the fact that the mnemonic phrase has been
/// loaded properly and should be visualized by the user.
class GenerateMnemonicLoaded extends GenerateMnemonicState {
  final List<String> mnemonic;
  final bool termsAccepted;

  GenerateMnemonicLoaded({
    required List<String> mnemonic,
    required this.termsAccepted,
  })   : assert(mnemonic.isNotEmpty),
        mnemonic = mnemonic;

  factory GenerateMnemonicLoaded.initial(List<String> mnemonic) {
    return GenerateMnemonicLoaded(
      mnemonic: mnemonic,
      termsAccepted: false,
    );
  }

  GenerateMnemonicLoaded copy({
    bool? creatingAddress,
    List<String>? mnemonic,
    bool? termsAccepted,
  }) {
    return GenerateMnemonicLoaded(
      mnemonic: mnemonic ?? this.mnemonic,
      termsAccepted: termsAccepted ?? this.termsAccepted,
    );
  }

  @override
  List<Object> get props => [mnemonic, termsAccepted];
}
