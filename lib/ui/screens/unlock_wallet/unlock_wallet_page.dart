import 'package:dam/ui/export.dart';
import 'package:dam/ui/screens/unlock_wallet/block/unlock_wallet_bloc.dart';
import 'package:dam/ui/screens/unlock_wallet/block/unlock_wallet_event.dart';
import 'package:dam/ui/screens/unlock_wallet/block/wallet_state.dart';
import 'package:dam/ui/widget/password_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UnlockWalletPage extends StatelessWidget {
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider<UnlockWalletBloc>(
            create: (_) => UnlockWalletBloc(),
            child: BlocBuilder<UnlockWalletBloc, WalletState>(
              builder: (context, state) {
                if (state is WalletStateLocked) {
                  return _unlockPage(context, false);
                }
                else if (state is WalletStateUnlocking) {
                  return LoadingBar();
                }
                else if (state is WalletStateUnlocked) {
                  return GenerateAccountPage(accountsNumber: 3, mnemonic: state.mnemonic.split(' '));
                }
                else {
                  if (state is WalletStateError) {
                    if (state.errorKind == WalletStateErrorKind.WrongPassword) {
                      return _unlockPage(context, true);
                    }
                    else {
                      return _errorPage(state.message ?? 'Unknown error');
                    }
                  }
                  return _errorPage('Fatal error, invalid state...');
                }
              },
            ),
          )
      ),
    );
  }

  Widget _unlockPage(BuildContext context, bool wrong_password) {
    return Center(
      child: Column(
        children: [
          PasswordField('Password', wrong_password ? 'Wrong password' : null, _passwordController),
          LightButton(text: 'Unlock', onPressed: () => _onUnlock(context)),
        ],
      ),
    );
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

  void _onUnlock(BuildContext context) {
    context.read<UnlockWalletBloc>().add(
        UnlockWalletEventUnlock(_passwordController.text));
  }
}
