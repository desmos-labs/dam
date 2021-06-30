import 'package:dam/ui/widget/password_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../export.dart';
import 'bloc/export.dart';

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
        body: ContentContainer(
      child: BlocProvider(
        create: (_) => CreateWalletBloc(),
        child: BlocBuilder<CreateWalletBloc, CreateWalletState?>(
            builder: (context, state) {
          if (state == null) {
            return _passwordsInput(context);
          } else if (state is CreateWalletCreating) {
            return LoadingBar();
          } else {
            return _walletCreated(context);
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
      PasswordField(labelText: 'Password', controller: _passwordController),
      PasswordField(
          labelText: 'Confirm password',
          controller: _confirmPasswordController,
          onFieldSubmitted: (_) => _saveMnemonic(context)),
      SizedBox(height: 8),
      PrimaryButton(
        text: AppLocalizations.of(context)!.confirmPasswordButtonText,
        onPressed: () => _saveMnemonic(context),
      ),
    ]);
  }

  Widget _walletCreated(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Image.asset(
            'assets/account-generated.png',
          ),
        ),
        SizedBox(height: DesmosPlatform.isMobile(context) ? 16 : 24),
        Text(
          AppLocalizations.of(context)!.walletCreatedMessage,
          style: DesmosTextStyles.largeBody(context),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: DesmosPlatform.isMobile(context) ? 16 : 24),
        PrimaryButton(
            text: AppLocalizations.of(context)!.confirmPasswordButtonText,
            onPressed: () {
              DesmosRoutes.navigateToUnlockWallet(context);
            }),
      ],
    );
  }

  void _saveMnemonic(BuildContext context) {
    if (_passwordController.text == _confirmPasswordController.text) {
      context.read<CreateWalletBloc>().add(
          CreateNewWalletEvent(mnemonic.join(' '), _passwordController.text));
    } else {}
  }
}
