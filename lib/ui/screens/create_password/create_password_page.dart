import 'package:dam/ui/screens/create_password/bloc/create_wallet_bloc.dart';
import 'package:dam/ui/screens/create_password/bloc/create_wallet_event.dart';
import 'package:dam/ui/screens/unlock_wallet/unlock_wallet_page.dart';
import 'package:dam/ui/widget/light_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../export.dart';
import 'bloc/create_wallet_state.dart';

/// Page that is showed after generating a new wallet or after importing an
/// existing one.
/// It is used to let the user create the password usd to securely store
/// the user's wallet into the device storage.
class CreateWalletPasswordPage extends StatelessWidget {
  final List<String> mnemonic;

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  CreateWalletPasswordPage({
    Key? key,
    required this.mnemonic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocProvider(
        create: (_) => CreateWalletBloc(),
        child: BlocBuilder<CreateWalletBloc, CreateWalletState?>(
            builder: (context, state) {
          if (state == null) {
            return _passwordsInput(context);
          } else if (state is CreateWalletCreating) {
            return LoadingBar();
          } else {
            return Column(children: [
              Text('Wallet created'),
              LightButton(
                text: AppLocalizations.of(context)!.confirmPasswordButtonText,
                onPressed: () => DesmosRoutes.navigateToUnlockWallet(context)
              ),
            ],);
          }
        }),
      ),
    ));
  }

  Widget _passwordsInput(BuildContext context) {
    return Column(children: [
      Text(
        AppLocalizations.of(context)!.walletPasswordMessage,
        style: DesmosTextStyles.thinBodyBlack(context),
      ),
      SizedBox(height: 8),
      _passwordField('Password', controller: _passwordController),
      _passwordField('Confirm password',
          controller: _confirmPasswordController),
      SizedBox(height: 8),
      LightButton(
        text: AppLocalizations.of(context)!.confirmPasswordButtonText,
        onPressed: () => _saveMnemonic(context),
      ),
    ]);
  }

  Widget _passwordField(String text, {TextEditingController? controller}) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: text,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          )),
      obscureText: true,
      enabled: true,
      maxLines: 1,
      controller: controller,
    );
  }

  void _saveMnemonic(BuildContext context) {
    if (_passwordController.text == _confirmPasswordController.text) {
      context.read<CreateWalletBloc>().add(
          CreateNewWalletEvent(mnemonic.join(' '), _passwordController.text));
    } else {}
  }
}
