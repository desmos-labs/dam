import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

class DesmosAddressViewer extends StatelessWidget {
  final String address;

  const DesmosAddressViewer({
    Key key,
    @required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Color(0xFFF1F1F1),
      ),
      padding: EdgeInsets.all(14),
      child: Text(
        address,
        style: DesmosTextStyles.thinBodyBlack(context),
      ),
    );
  }
}
