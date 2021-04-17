import 'package:dam/ui/export.dart';
import 'package:flutter/material.dart';

/// Represents the loading page that is shown to the web users when they click
/// on the "Next" button.
///
/// This loading page will be shown only on web platforms as such platforms
/// cannot execute the code on a different thread and the "Next" button callback
/// might execute expensive operations. In order to avoid blocking the UI
///  immediately, when then show the loading page and (possibly) freeze on that.
class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (!DesmosPlatform.isWeb) {
      return Container();
    }

    return Container(
      color: Colors.white.withAlpha(220),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.generatingAccountsTitle,
              style: DesmosTextStyles.largeBody(context),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.generatingAccountsBody,
              style: DesmosTextStyles.thinBodyGrey(context),
            ),
            SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)!.doNotClosePage,
              style: DesmosTextStyles.thinBodyGrey(context),
            ),
          ],
        ),
      ),
    );
  }
}
