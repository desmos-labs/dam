import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// Represents a reload button.
class ReloadButton extends StatelessWidget {
  final void Function() onPressed;

  const ReloadButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/icon-reload.png', width: 12),
            SizedBox(width: 6),
            Text(
              AppLocalizations.of(context)!.random,
              style: DesmosTextStyles.secondaryButton(context),
            ),
          ],
        ),
      ),
    );
  }
}
