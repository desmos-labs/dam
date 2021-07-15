import 'package:dam/ui/export.dart';
import 'package:dam/wallet/export.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.only(top: 14, bottom: 14, left: 8, right: 8),
      child: Row(
        //mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.path}: ${DesmosWallet.getPath(index)}',
                  style: DesmosTextStyles.thinBodyBlack(context),
                ),
                Text(
                  '${AppLocalizations.of(context)!.address}:',
                  style: DesmosTextStyles.thinBodyBlack(context),
                ),
                SelectableText(
                  address,
                  style: DesmosTextStyles.thinBodyBlack(context),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
