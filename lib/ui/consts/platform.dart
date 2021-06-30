import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Utility class to deal with different supported platforms.
class DesmosPlatform {
  /// Returns [true] iff the application is running on a mobile platform.
  static bool isMobile(BuildContext context) {
    if (kIsWeb) {
      final query = MediaQuery.of(context);
      final width = query.size.width / query.devicePixelRatio;
      return width < 720;
    } else {
      return Platform.isAndroid || Platform.isIOS;
    }
  }

  /// Returns `true` iff the application is running on a tablet platform.
  static bool isTablet(BuildContext context) {
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
      final query = MediaQuery.of(context);
      final width = query.size.width / query.devicePixelRatio;
      return width >= 720 && width < 960;
    }
    return false;
  }

  /// Returns `true` iff the application is running on a desktop computer.
  static bool get isDesktop {
    if (kIsWeb) {
      return false;
    } else {
      return Platform.isLinux || Platform.isMacOS || Platform.isWindows;
    }
  }

  /// Returns `true` iff the application is running on a web platform.
  static bool get isWeb {
    return kIsWeb;
  }
}
