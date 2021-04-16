import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/export.dart';
import 'bloc/export.dart';

/// This page is shown to the user when they navigate here from the main screen.
/// It is used to generate a new Desmos account data and let them copy the
/// output values (address, mnemonic, etc).
class GenerateMnemonicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => GenerateMnemonicBloc()..add(GenerateNewMnemonic()),
        child: SafeArea(
          child: BlocBuilder<GenerateMnemonicBloc, GenerateMnemonicState>(
            builder: (context, state) {
              if (state is GenerateMnemonicLoading) {
                return LoadingBar();
              }

              final generatedState = state as GenerateMnemonicLoaded;
              return Stack(
                children: [
                  GeneratedAccountBody(
                    words: generatedState.mnemonic,
                    onNext: (mnemonic) => _onNext(context, mnemonic),
                  ),
                  if (generatedState.creatingAddress) LoadingBar(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onNext(BuildContext context, List<String> mnemonic) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return VerifyMnemonicPage(mnemonic: mnemonic);
    }));
  }
}
