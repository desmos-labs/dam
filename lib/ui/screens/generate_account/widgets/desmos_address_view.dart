import 'package:dam/wallet/export.dart';
import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

class DesmosAddressViewer extends StatelessWidget {
  final int index;
  final String address;

  const DesmosAddressViewer({
    Key? key,
    required this.index,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xFFF1F1F1),
      ),
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppLocalizations.of(context)!.path}: ${DesmosWallet.getPath(index)}',
                style: DesmosTextStyles.thinBodyBlack(context),
              ),
              Text(
                '${AppLocalizations.of(context)!.address}: $address',
                style: DesmosTextStyles.thinBodyBlack(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
