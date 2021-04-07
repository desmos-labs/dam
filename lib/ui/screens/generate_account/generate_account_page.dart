import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/export.dart';
import 'cubit/export.dart';

/// This page is shown to the user when they navigate here from the main screen.
/// It is used to generate a new Desmos account data and let them copy the
/// output values (address, mnemonic, etc).
class GenerateAccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => GenerateAccountCubit()..random(),
        child: SafeArea(
          child: BlocBuilder<GenerateAccountCubit, GenerateAccountState>(
            builder: (context, state) {
              if (state is GenerateAccountLoading) {
                return Container();
              }

              final generatedState = state as GenerateAccountLoaded;
              return GeneratedAccountBody(
                words: generatedState.mnemonic,
                onRandomPressed: () => _getRandomMnemonic(context),
                onGenerateAccountPressed: () => _generateAccount(context),
              );
            },
          ),
        ),
      ),
    );
  }

  void _getRandomMnemonic(BuildContext context) {
    context.read<GenerateAccountCubit>().random();
  }

  /// Method called when the user presses the "Generate account" button.
  void _generateAccount(BuildContext context) {
    final cubit = context.read<GenerateAccountCubit>();
    final address = cubit.getAddress();
    if (address != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return AccountGeneratedPage(address: address);
      }));
    }
  }
}
