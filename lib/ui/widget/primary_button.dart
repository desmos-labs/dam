import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Represents a primary-color background button.
class PrimaryButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) => getButtonColor(context, states),
              ),
            ),
            child: Container(
              padding: DesmosPlatform.isMobile
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(vertical: 10),
              child: Text(
                text,
                style: Theme.of(context).textTheme.button?.copyWith(
                      color: Colors.white,
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

  Color getButtonColor(BuildContext context, Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled)) {
      return Theme.of(context).disabledColor;
    }
    return Theme.of(context).primaryColor;
  }
}
