import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

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
      body: ContentContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 5,
              child: Column(
                children: [
                  Image.asset(
                    'assets/account-generated.png',
                    width: DesmosPlatform.isMobile(context) ? 280 : 400,
                  ),
                  SizedBox(height: DesmosPlatform.isMobile(context) ? 16 : 24),
                  Text(
                    AppLocalizations.of(context)!.accountGenerated,
                    style: DesmosTextStyles.largeBody(context),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppLocalizations.of(context)!.desmosAddress,
                    style: DesmosTextStyles.thinBodyBlack(context),
                  ),
                  SizedBox(height: 8),
                  DesmosAddressViewer(address: address),
                  SizedBox(height: 8),
                  PrimaryButton(
                    text: AppLocalizations.of(context)!.copy,
                    onPressed: () => _onCopyPressed(context),
                  ),
                ],
              ),
            ),
          ],
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
