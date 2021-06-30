import 'package:dam/ui/widget/password_filed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../export.dart';
import 'bloc/export.dart';

/// Page that is showed after generating a new wallet or after importing an
/// existing one.
/// It is used to let the user create the password used to secure
/// the user's wallet into the device storage.
class CreateWalletPasswordPage extends StatelessWidget {
  final List<String> mnemonic;

  final _formKey = GlobalKey<FormState>();
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
    return Form(
        key: _formKey,
        child: Column(children: [
          Text(
            AppLocalizations.of(context)!.walletPasswordMessage,
            style: DesmosTextStyles.thinBodyBlack(context),
          ),
          SizedBox(height: 8),
          PasswordField(
            labelText: AppLocalizations.of(context)!.password,
            controller: _passwordController,
            validator: (string) => _validatePassword(context, string),
          ),
          PasswordField(
              labelText: AppLocalizations.of(context)!.confirmPassword,
              controller: _confirmPasswordController,
              validator: (string) {
                if (string != _passwordController.text) {
                  return AppLocalizations.of(context)!.passwordDontMatch;
                }
                return null;
              },
              onFieldSubmitted: (_) => _confirmPassword(context)),
          SizedBox(height: 8),
          PrimaryButton(
            text: AppLocalizations.of(context)!.confirmPasswordButtonText,
            onPressed: () => _confirmPassword(context),
          ),
        ]));
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

  void _confirmPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<CreateWalletBloc>().add(
          CreateNewWalletEvent(mnemonic.join(' '), _passwordController.text));
    }
  }

  String? _validatePassword(BuildContext context, String? password) {
    if (password == null || password.isEmpty) {
      return AppLocalizations.of(context)!.passwordComplexityErrorEmpty;
    }
    var uppercase = 0;
    var numbers = 0;
    var specialChars = 0;

    final digitRegex = RegExp(r'[0-9]');
    final specialCharsRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

    for (var i = 0; i < password.length; i++) {
      var char = password.substring(i, i + 1);
      if (char.contains(digitRegex)) {
        numbers++;
      } else if (char.contains(specialCharsRegex)) {
        specialChars++;
      } else if (password.substring(i, i + 1).toUpperCase() == char) {
        uppercase++;
      }
    }

    if (uppercase < 1) {
      return AppLocalizations.of(context)!.passwordComplexityErrorUppercase;
    } else if (numbers < 1) {
      return AppLocalizations.of(context)!.passwordComplexityErrorNumbers;
    } else if (specialChars < 1) {
      return AppLocalizations.of(context)!.passwordComplexityErrorSpecialChars;
    }

    return null;
  }
}
