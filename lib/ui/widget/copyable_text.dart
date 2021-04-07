import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget contains a text that can be copied either selecting it or by
/// pressing the copy button at the end of the screen.
class CopyableText extends StatelessWidget {
  final String text;

  const CopyableText({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SelectableText(text),
          GestureDetector(
            child: Icon(
              Icons.copy,
              color: Theme.of(context).primaryColor,
            ),
            onTap: () {
              FlutterClipboard.copy(text).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(AppLocalizations.of(context)!.textCopied),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}
