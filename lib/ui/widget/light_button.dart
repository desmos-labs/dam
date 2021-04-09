import 'package:dam/ui/consts/export.dart';
import 'package:flutter/material.dart';

/// Represents a light-background button.
class LightButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const LightButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
            ),
            child: Container(
              padding: DesmosPlatform.isMobile(context)
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(vertical: 10),
              child: Text(
                text,
                style: Theme.of(context).textTheme.button!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
