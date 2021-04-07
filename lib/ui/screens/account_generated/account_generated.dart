import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'desmos_address_view.dart';

/// Page that is shown to the user when they have generated a new account.
/// It contains the address and the option to copy it.
class AccountGeneratedPage extends StatelessWidget {
  final String address;

  const AccountGeneratedPage({
    Key? key,
    required this.address,
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
      body: SafeArea(
        child: Container(
          padding: DesmosPlatform.isMobile
              ? EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 30)
              : EdgeInsets.symmetric(horizontal: 360, vertical: 160),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/account-generated.png',
                      width: DesmosPlatform.isMobile ? 280 : 560,
                    ),
                    SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.accountGenerated,
                      style: DesmosTextStyles.largeBody(context),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.desmosAddress,
                    style: DesmosTextStyles.thinBodyBlack(context),
                  ),
                  SizedBox(height: 8),
                  DesmosAddressViewer(address: address),
                  SizedBox(height: 24),
                  PrimaryButton(
                    text: AppLocalizations.of(context)!.copy,
                    onPressed: () => _onCopyPressed(context),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onClosePressed(BuildContext context) {
    Navigator.pop(context);
  }

  void _onCopyPressed(BuildContext context) {
    FlutterClipboard.copy(address).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.textCopied),
      ));
    });
  }
}
