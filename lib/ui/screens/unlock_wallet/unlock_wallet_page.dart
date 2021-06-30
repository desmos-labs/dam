import 'package:dam/blocs/wallet/wallet_bloc.dart';
import 'package:dam/blocs/wallet/wallet_event.dart';
import 'package:dam/blocs/wallet/wallet_state.dart';
import 'package:dam/ui/export.dart';
import 'package:dam/ui/widget/password_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnlockWalletPage extends StatelessWidget {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WalletBloc>(
      create: (_) => WalletBloc.newInstance(),
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletStateLocked) {
            return _unlockPage(context, false);
          } else if (state is WalletStateUnlocking) {
            return LoadingBar();
          } else if (state is WalletStateUnlocked) {
            return ShowAddressesPage(
                accountsNumber: 3, mnemonic: state.mnemonic);
          } else {
            if (state is WalletStateError) {
              if (state.errorKind == WalletStateErrorKind.WrongPassword) {
                return _unlockPage(context, true);
              } else {
                return _errorPage(state.message ?? 'Unknown error');
              }
            }
            return _errorPage('Fatal error, invalid state...');
          }
        },
      ),
    );
  }

  Widget _unlockPage(BuildContext context, bool wrong_password) {
    return Scaffold(
        body: ContentContainer(
            child: Center(
      child: Column(
        children: [
          PasswordField(
              labelText: 'Password',
              errorText: wrong_password ? 'Wrong password' : null,
              controller: _passwordController,
              onFieldSubmitted: (_) => _onUnlockPressed(context)),
          PrimaryButton(
              text: 'Unlock', onPressed: () => _onUnlockPressed(context)),
        ],
      ),
    )));
  }

  Widget _errorPage(String message) {
    return Center(
      child: Column(
        children: [
          Text(message),
        ],
      ),
    );
  }

  void _onUnlockPressed(BuildContext context) {
    var password = _passwordController.text;
    // Clear so that when returning to this page the password field will be empty.
    _passwordController.clear();
    context.read<WalletBloc>().add(WalletEventUnlock(password));
  }
}
