import 'package:dam/ui/export.dart';
import 'package:dam/ui/screens/import_mnemonic/widgets/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/export.dart';

/// Page that is shown to the user when they want to import an already existing
/// mnemonic phrase. It allows to insert the 24 words and then generate the
/// account from those.
class ImportMnemonicPhrasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider<ImportMnemonicCubit>(
        create: (context) => ImportMnemonicCubit(),
        child: Builder(
          builder: (context) {
            return SafeArea(
              child: Stack(
                children: [
                  ImportMnemonicBody(
                    onWordChanged: (index, word) {
                      _onWordChanged(context, index, word);
                    },
                    onNext: () => _onNext(context),
                  ),
                  BlocBuilder<ImportMnemonicCubit, ImportMnemonicState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: state.creatingAddress,
                        child: LoadingBar(),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// Called when the word at the given index changes.
  void _onWordChanged(BuildContext context, int index, String word) {
    context.read<ImportMnemonicCubit>().updateWord(index, word);
  }

  /// Called when the user presses the "Next" button.
  void _onNext(BuildContext context) {
    final cubit = context.read<ImportMnemonicCubit>();
    final address = cubit.getAddress();
    if (address != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return AccountGeneratedPage(address: address);
      }));
    }
  }
}
