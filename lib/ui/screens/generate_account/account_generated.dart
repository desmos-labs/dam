import 'package:dam/blocs/wallet/wallet_bloc.dart';
import 'package:dam/blocs/wallet/wallet_event.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/export.dart';
import 'widgets/export.dart';

/// Page that is shown to the user when they have generated a new account.
/// It contains the address and the option to copy it.
class ShowAddressesPage extends StatelessWidget {
  final int accountsNumber;
  final List<String> mnemonic;

  const ShowAddressesPage({
    Key? key,
    required this.accountsNumber,
    required this.mnemonic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => _onClosePressed(context),
          ),
        ],
      ),
      body: BlocProvider<GenerateAccountBloc>(
        create: (context) => GenerateAccountBloc()
          ..add(GenerateAccounts(accountsNumber, mnemonic)),
        child: BlocBuilder<GenerateAccountBloc, GenerateAccountState>(
          builder: (context, state) {
            final currentState = state;
            if (currentState is GenerateAccountCompleted) {
              return AccountGeneratedBody(addresses: currentState.addresses);
            }
            return LoadingBar();
          },
        ),
      ),
    );
  }

  /// Called when the close button is pressed
  void _onClosePressed(BuildContext context) {
    context.read<WalletBloc>().add(WalletEventLock());
  }
}
