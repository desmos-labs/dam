import 'package:clipboard/clipboard.dart';
import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

import 'desmos_address_view.dart';

/// Represents the body of the account generation page when the accounts are
/// generated successfully.
class AccountGeneratedBody extends StatelessWidget {
  final List<String> addresses;

  const AccountGeneratedBody({
    Key? key,
    required this.addresses,
  }) : super(key: key);

  String get address {
    return addresses.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ContentContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image.asset(
              'assets/account-generated.png',
            ),
          ),
          SizedBox(height: DesmosPlatform.isMobile(context) ? 16 : 24),
          Text(
            AppLocalizations.of(context)!.accountGenerated,
            style: DesmosTextStyles.largeBody(context),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: DesmosPlatform.isMobile(context) ? 16 : 24),
          ListView.separated(
            shrinkWrap: true,
            itemCount: addresses.length + 1,
            itemBuilder: (context, index) {
              if (index == addresses.length) {
                return PrimaryButton(
                  text: AppLocalizations.of(context)!.copyAddresses,
                  onPressed: () => _onCopyPressed(context),
                );
              }

              return DesmosAddressViewer(
                index: index,
                address: addresses[index],
              );
            },
            separatorBuilder: (c, i) {
              return SizedBox(height: 8);
            },
          ),
        ],
      ),
    );
  }

  void _onCopyPressed(BuildContext context) {
    FlutterClipboard.copy(address).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.textCopied),
      ));
    });
  }
}
