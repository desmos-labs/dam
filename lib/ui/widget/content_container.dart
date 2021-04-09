import 'package:flutter/material.dart';
import 'package:dam/ui/export.dart';

/// Allows to display the given child in two different ways based on the
/// current platform on which the application is executing.
///
/// If the application is running on a mobile device, and [scrollable] is `
/// false`, the [child] will be placed inside a [Container] with an
/// horizontal padding. Otherwise, if [scrollable] is set to `true`, it will
/// be placed inside a [SingleChildScrollView].
///
/// If the application is running either on a web platform or a desktop
/// platform, the [child] will be placed inside a centered container with a
/// padding of 16 and [DesmosSizes.desktopConstraints] constraints.
class ContentContainer extends StatelessWidget {
  final Widget child;
  final bool scrollable;

  const ContentContainer({
    Key? key,
    required this.child,
    this.scrollable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    if (!DesmosPlatform.isDesktop) {
      final query = MediaQuery.of(context);
      final height = query.size.height - kToolbarHeight - 25 - 32;
      final padding = EdgeInsets.all(16);
      return scrollable
          ? SingleChildScrollView(
              padding: padding,
              child: SizedBox(
                height: height,
                child: child,
              ),
            )
          : Container(
              padding: padding,
              child: child,
            );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Column(
          children: [
            Visibility(visible: screen.height >= 550, child: Spacer(flex: 1)),
            Flexible(
              flex: 11,
              child: Container(
                constraints: DesmosSizes.desktopConstraints,
                padding: EdgeInsets.all(16),
                child: child,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
